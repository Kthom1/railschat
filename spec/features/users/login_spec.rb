require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  background do
    visit root_path
  end

  scenario 'existing user successfully logs in', js: true do
    within('form') do
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
    end
    click_on 'Log in'
    expect(page).to have_content('Welcome to Rails Chat!')
  end

end