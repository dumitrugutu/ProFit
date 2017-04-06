require "rails_helper"

RSpec.feature "Searching Members" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")
  end

  scenario "returns all members that match the query" do
    visit "/"

    fill_in "search_name", with: "Doe"

    expect(page).to have_content(@joe.full_name)
    expect(current_path).to eq("/dashboards/search")
  end

end
