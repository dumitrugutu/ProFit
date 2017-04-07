require "rails_helper"

RSpec.feature "Following Members" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")

    login_as(@joe)
  end

  scenario "when signed in" do
    visit "/"

    expect(page).to have_content(@joe.full_name)
    expect(page).to have_content(@lisa.full_name)

    href = "/friendships?friend_id=#{@joe.id}"
    expect(page).not_to have_link("Follow", href: href)

    link = "a[href='/friendships?friend_id=#{@lisa.id}']"
    find(link).click

    href = "/friendships?friend_id=#{@lisa.id}"
    expect(page).not_to have_link("Follow", href: href)
  end
end
