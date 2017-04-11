require "rails_helper"

RSpec.feature "Showing Friend's Workout" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")

    @workout1 = @joe.workouts.create!(duration: 55, workout_type: "30 pushups, 30 squats, 30 legs curls", date: Date.today )
    @workout2 = @lisa.workouts.create!(duration: 60, workout_type: "20 pushups, 20 squats, 20 legs curls", date: 1.days.ago )

    login_as(@joe)

    @following = Friendship.create!(user_id: @joe.id, friend_id: @lisa.id)
  end

  scenario "in the past 7 days" do
    visit "/"

    click_link @lisa.full_name

    expect(page).to have_content(@lisa.full_name + "'s Workouts")
    expect(page).to have_content(@workout2.workout_type)
    expect(page).to have_css("div#chart")
  end
end
