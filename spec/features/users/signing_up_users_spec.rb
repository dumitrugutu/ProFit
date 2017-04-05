require "rails_helper"

RSpec.feature "Users signup" do

  scenario "with valid credentials" do

    visit "/"

    click_link "Sign up"
    fill_in "Full name", with: "Joe Doe"
    fill_in "Email", with: "joe@example.com"
    fill_in "Password",  with: "password"
    fill_in "Password confirmation",  with: "password"
    click_button "Sign up"

    expect(page).to have_content("You have signed up successfully.")

    visit "/"
    expect(page).to have_content("Joe Doe")
  end

end
