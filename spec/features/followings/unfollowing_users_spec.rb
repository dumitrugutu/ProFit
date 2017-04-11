require "rails_helper"

RSpec.feature "Unfollowing Members" do
  before do
    @joe = User.create!(full_name: "Joe Doe", email: "joe@example.com", password: "password")
    @lisa = User.create!(full_name: "Lisa Morris", email: "lisa@example.com", password: "password")

    login_as(@joe)
  end

  scenario "when signed in" do
    visit "/"

    follow_link = "a[href='/friendships?friend_id=#{@lisa.id}']"
    find(follow_link).click

    unfollow_link = "/friendships/#{@lisa.id}"
    expect(page).to have_link("Unfollow", href: unfollow_link)
    expect(page).to have_content("You have unfollowed #{@lisa.full_name} successfully")
  end
end
