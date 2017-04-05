require "rails_helper"

RSpec.feature "Editing Workout" do

  before do
    @joe = User.create!(email: "joe@example.com", password: "password")

    @workout = @joe.workouts.create!(duration: 55, workout_type: "25 pushups, 25 squats, 25 legs curls", date: Date.today )

    login_as(@joe)
  end

  scenario "succeeds with valid imput" do
    visit "/"

    click_link "My Workouts"

    path = "/users/#{@joe.id}/workouts/#{@workout.id}"
    link = "//a[contains(@href,\'#{path}\') and .//text()='Destroy']"
    find(:xpath, link).click


    expect(page).to have_content("Workout has been deleted")
  end
end