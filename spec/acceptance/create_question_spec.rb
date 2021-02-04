require_relative 'acceptance_helper'

feature 'Create Question', '
  In order to get answer from community
  As an authenticated User
  I want to be able to ask questions
' do
  given(:user) { create(:user) }

  def fill_in_form
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'
  end

  scenario 'Authenticated User creates Question', js: true do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in_form
    expect(page).to have_content 'Test question'
  end

  scenario 'Non-authenticated User tries to create Question' do
    visit root_path
    click_on 'New question'

    expect(page).to have_content 'Log in'
  end
end
