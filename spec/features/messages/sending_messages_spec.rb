require "rails_helper"

RSpec.feature "Sending a message" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")
    @tom = User.create!(full_name: "Tom Jones", email: "tom@example.com", password: "password")

    @room_name = @joe.full_name.split.join("-")
    @room = Room.create!(name: @room_name, user_id: @joe.id)

    login_as(@joe)

    Friendship.create!(user_id: @lisa.id, friend_id: @joe.id)
    Friendship.create!(user_id: @tom.id, friend_id: @joe.id)
  end

  scenario "to followers in chatroom window" do
    visit "/"

    click_link "My Workouts"
    expect(page).to have_content(@room_name)

    fill_in "message-field", with: "Hello"
    click_button "Send"

    expect(page).to have_content("Hello")

    within("#followers") do
      expect(page).to have_link(@lisa.full_name)
      expect(page).to have_link(@tom.full_name)
    end
  end

end
