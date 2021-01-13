feature 'User answer', '
  In order to exchange my knowledge
  I want to be able to create answers
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Non-authenticated User tries to create answer', js: true do
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'
    expect(page).to eq page
  end

  scenario 'Authenticated user create answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'

    sleep(5)

    expect(page).to have_content 'My answer'
  end
end
