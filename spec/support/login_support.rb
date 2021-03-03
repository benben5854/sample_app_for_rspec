module LoginSupport
  def sign_in_as(user)
    visit login_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "123456"
    click_button "Login"
  end
end
