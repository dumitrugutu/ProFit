require "rails_helper"

RSpec.feature "Listing Workout" do
  before do
    @joe = User.create!(email: "joe@example.com", password: "password")
    login_as(@joe)

    @workout1 = @joe.workouts.create(duration: 55, workout_details: "25 pushups, 25 squats, 25 legs curls", activity_date: Date.today )
    @workout2 = @joe.workouts.create(duration: 60, workout_details: "20 pushups, 20 squats, 20 legs curls", activity_date: 1.days.ago )
  end

  scenario "shows user's workout for the past 7 days" do
    visit "/"

    click_link "My Workouts"

    expect(page).to have_content(@workout1.duration)
    expect(page).to have_content(@workout1.workout_type)
    expect(page).to have_content(@workout1.date)

    expect(page).to have_content(@workout2.duration)
    expect(page).to have_content(@workout2.workout_type)
    expect(page).to have_content(@workout2.date)
  end
end
