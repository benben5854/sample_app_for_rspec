require 'rails_helper'

RSpec.describe "UserSessions", type: :system do

  describe 'ログイン前' do
    context 'フォームの入力値が正常' do
      it 'ログイン処理が成功する' do
        user = FactoryBot.create(:user)
        
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: "123456"
        click_button 'Login'
        
        expect(page).to have_content("Login successful")
      end
    end
    context 'フォームが未入力' do
      it 'ログイン処理が失敗する' do
        user = FactoryBot.create(:user)
        visit login_path
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        click_button 'Login'
        
        expect(page).to have_content("Login failed")
        expect(page).to have_current_path "/login"
      end
    end
  end
  
  describe 'ログイン後' do
    context 'ログアウトボタンをクリック' do
      it 'ログアウト処理が成功する' do
        user = FactoryBot.create(:user)
        visit login_path
        fill_in "Email", with: user.email
        fill_in "Password", with: "123456"
        click_button 'Login'
        click_link 'Logout'
        
        expect(page).to have_content("Logged out")
        expect(current_path).to eq root_path
      end
    end
  end
end
