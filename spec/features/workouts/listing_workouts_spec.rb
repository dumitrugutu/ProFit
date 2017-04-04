require "rails_helper"

RSpec.feature "Listing Workout" do
  before do
    @joe = User.create!(email: "joe@example.com", password: "password")
    login_as(@joe)

    @workout1 = @joe.workouts.create!(duration: 55, workout_type: "25 pushups, 25 squats, 25 legs curls", date: Date.today )
    @workout2 = @joe.workouts.create!(duration: 60, workout_type: "20 pushups, 20 squats, 20 legs curls", date: 1.days.ago )
    @workout3 = @joe.workouts.create!(duration: 65, workout_type: "25 pushups, 25 squats, 25 legs curls", date: 9.days.ago )
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

    expect(page).not_to have_content(@workout3.duration)
    expect(page).not_to have_content(@workout3.workout_type)
    expect(page).not_to have_content(@workout3.date)
  end

  scenario "shows no workouts if none created" do
    @joe.workouts.delete_all

    visit "/"

    click_link "My Workouts"
    expect(page).to have_content("No Workouts to show")
  end
end
