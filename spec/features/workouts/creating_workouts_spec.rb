require "rails_helper"

RSpec.feature "Creating Workout" do

  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    login_as(@joe)
  end

  scenario "with valid imput" do
    visit "/"

    click_link "My Workouts"
    click_link "New Workout"
    expect(page).to have_link("Back")

    fill_in "Duration", with: 60
    fill_in "Workout details", with: "Pushups"
    fill_in "Activity date", with: 2.days.ago
    click_button "Save Workout"

    expect(page).to have_content("Workout has been created")

    workout = Workout.last
    expect(current_path).to eq(user_workout_path(@joe, workout))
    expect(workout.user_id).to eq(@joe.id)
  end

  scenario "with invalid inputs" do
   visit "/"

   click_link "My Workouts"
   click_link "New Workout"
   expect(page).to have_link("Back")

   fill_in "Duration", with: ""
   fill_in "Workout details",  with: ""
   fill_in "Activity date",  with: ""
   click_button "Save Workout"

   expect(page).to have_content("Workout has not been created")
   expect(page).to have_content("Duration is not a number")
   expect(page).to have_content("Workout details can't be blank")
   expect(page).to have_content("Activity date can't be blank")
 end

end
