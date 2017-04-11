require "rails_helper"

RSpec.feature "Listing Members" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")

    login_as(@joe)
  end

  scenario "shows a list of members" do
    visit "/"

    expect(page).to have_content("Active Members")
    expect(page).to have_content(@joe.full_name)
    expect(page).to have_content(@lisa.full_name)
  end

end
