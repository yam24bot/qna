feature 'Create Question', '
  In order to get answer from community
  As an authicated User
  I want to be able to ask questions
' do
  given(:user) { create(:user) }
  let(:fill_in_form) do
    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Test body'
    click_on 'Create'
  end

  scenario 'Authenticated User creates Question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask question'
    fill_in_form
    expect(page).to have_content 'Your question successfully created!'
  end

  scenario 'Non-authenticated User tries to create Question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
