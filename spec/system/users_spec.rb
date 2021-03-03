require 'rails_helper'

RSpec.describe "Users", type: :system do

  describe 'ログイン前' do
    describe 'ユーザー新規登録' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの新規作成が成功する' do
          visit '/sign_up'
          fill_in "Email", with: "system_test@gmail.com"
          fill_in "Password", with: "123456"
          fill_in "Password confirmation", with: "123456"
          click_button "SignUp"
          
          expect(page).to have_content("User was successfully created.")
          expect(page).to have_current_path "/login"
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの新規作成が失敗する' do
          visit '/sign_up'
          fill_in "Email", with: ""
          fill_in "Password", with: "123456"
          fill_in "Password confirmation", with: "123456"
          click_button "SignUp"
          
          expect(page).to have_content("can't be blank")
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの新規作成が失敗する' do
          user = FactoryBot.create(:user)
          
          visit '/sign_up'
          fill_in "Email", with: "#{user.email}"
          fill_in "Password", with: "123456"
          fill_in "Password confirmation", with: "123456"
          click_button "SignUp"
          
          expect(page).to have_content("has already been taken")
        end
      end
    end

    describe 'マイページ' do
      context 'ログインしていない状態' do
        it 'マイページへのアクセスが失敗する' do
          visit '/users/1'
          expect(page).to have_content("Login required")
          expect(page).to have_current_path "/login"
        end
      end
    end
  end

  describe 'ログイン後' do
    describe 'ユーザー編集' do
      context 'フォームの入力値が正常' do
        it 'ユーザーの編集が成功する' do
          user = FactoryBot.create(:user)
          sign_in_as user
          
          visit edit_user_path(user)
          fill_in "Password", with: "123457"
          fill_in "Password confirmation", with: "123457"
          click_button "Update"
          
          expect(page).to have_content("User was successfully updated.")
        end
      end
      context 'メールアドレスが未入力' do
        it 'ユーザーの編集が失敗する' do
          user = FactoryBot.create(:user)
          sign_in_as user
          
          visit edit_user_path(user)
          fill_in "Email", with: ""
          fill_in "Password", with: "123457"
          fill_in "Password confirmation", with: "123457"
          click_button "Update"
          
          expect(page).to have_content("can't be blank")
        end
      end
      context '登録済のメールアドレスを使用' do
        it 'ユーザーの編集が失敗する' do
          user = FactoryBot.create(:user)
          anoter_user = FactoryBot.create(:user)
          sign_in_as user
          
          visit edit_user_path(user)
          fill_in "Email", with: anoter_user.email
          fill_in "Password", with: "123457"
          fill_in "Password confirmation", with: "123457"
          click_button "Update"
          
          expect(page).to have_content("has already been taken")
        end
      end
      context '他ユーザーの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          user = FactoryBot.create(:user)
          another_user = FactoryBot.create(:user)
          
          sign_in_as user
          
          visit edit_user_path(another_user)
          
          expect(page).to have_content("Forbidden access.")
        end
      end
      
      
    end
  end
end
