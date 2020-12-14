require 'rails_helper'

feature 'User sign in', %q{
  In order to be able to ask question
  As an User
  I want to be able sign in
} do
  scenario 'Registered User try to sign in' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end
  scenario 'Non-registered User try to sign in' do

    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Sign in'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_page).to eq new_user_session_path
  end
end