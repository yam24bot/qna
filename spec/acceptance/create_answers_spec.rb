feature 'User answer', '
  In order to exchange my knowledge
  I want to be able to create answers
', js: true do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Non-authenticated User tries to create answer' do
    visit question_path(question)

    fill_in 'Your answer', with: 'My answer'
    click_on 'Create'
    expect(page).to eq page
  end

  # scenario 'Authenticated user create answer' do
  #   sign_in(user)
  #   visit question_path(question)
  #
  #   fill_in 'Your answer', with: 'My answer'
  #   click_on 'Create'
  #   expect(page).to have_content 'Successfully created'
  # end
end
