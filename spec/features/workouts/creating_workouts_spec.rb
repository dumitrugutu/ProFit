require "rails_helper"

RSpec.feature "Creating Workout" do

  before do
    @joe = User.create!(email: "joe@example.com", password: "password")
    login_as(@joe)
  end

  scenario "with valid imput" do
    visit "/"

    click_link "My Workouts"
    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration", with: 60
    fill_in "Workout details", with: "Pushups"
    fill_in "Activity date", with: "2017-03-20"
    click_button "Save Workout"

    expect(page).to have_content("Workout has been created")

    workout = Workout.last
    expect(current_path).to eq(user_workout_path(@joe, workout))
    expect(workout.user_id).to eq(@joe.id)
  end

end
