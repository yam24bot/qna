feature 'User sign in', '
  In order to be able to ask question
  As an User
  I want to be able sign in
' do
  given(:user) { create(:user) }

  scenario 'Registered User try to sign in' do
    sign_in(user)
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered User try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    expect(current_path).to eq new_user_session_path
  end
end
