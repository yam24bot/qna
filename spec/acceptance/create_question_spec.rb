feature 'Create Question', %q{
  In order to get answer from community
  As an authicated User
  I want to be able to ask questions
} do

  scenario 'Authenticated User creates Question' do
    User.create!(email: 'user@test.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask question'
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'
    expect(page).to have_content 'Your question successfully created!'
  end

  scenario 'Non-authenticated User tries to create Question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end