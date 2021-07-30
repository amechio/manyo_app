require 'rails_helper'
RSpec.describe 'ユーザ機能', type: :system do

  describe 'ユーザ登録機能' do
    context 'ユーザを新規作成した場合' do
      it '作成したユーザが表示される' do
        visit new_user_path
        fill_in 'user[name]', with: '名前'
        fill_in 'user[email]', with: 'email@mail.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on '新規登録'
        expect(page).to have_content '名前'
        expect(page).to have_content 'email@mail.com'
      end
    end

    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移' do
        visit tasks_path
        expect(page).to have_content 'ログイン'
      end
    end
  end

  describe 'セッション機能' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
      @user3 = FactoryBot.create(:user3)
      visit new_session_path
      fill_in 'session[email]', with: 'factory1@mail.com'
      fill_in 'session[password]', with: 'factory1'
      click_on 'ログイン'
    end

    context 'ログインしたとき' do
      it 'ようこそと表示される' do
        sleep 1
        expect(page).to have_content 'ようこそ'
      end

      it '自分の詳細画面(マイページ)に飛べる' do
        expect(page).to have_content 'のページ'
      end

      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移する' do
        visit new_session_path
        fill_in 'session[email]', with: 'factory2@mail.com'
        fill_in 'session[password]', with: 'factory2'
        click_on 'ログイン'
        visit user_path(@user3.id)
        expect(page).to have_content '権限がありません'
      end

      it 'ログアウトができる' do
        click_on 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end

  describe '管理機能' do
    before do
      @user = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user2)
      @user3 = FactoryBot.create(:user3)
      visit new_session_path
      fill_in 'session[email]', with: 'factory1@mail.com'
      fill_in 'session[password]', with: 'factory1'
      click_on 'ログイン'
      visit admin_users_path
    end

    context '管理ユーザが登録されているとき' do
      it '管理ユーザは管理画面にアクセスできる' do
        expect(page).to have_content '管理者画面index'
      end

      it '一般ユーザは管理画面にアクセスできない' do
        visit new_session_path
        fill_in 'session[email]', with: 'factory2@mail.com'
        fill_in 'session[password]', with: 'factory2'
        click_on 'ログイン'
        visit admin_users_path
        expect(page).to have_content '権限がありません'
      end

      it '管理ユーザはユーザの新規登録ができる' do
        click_on 'ユーザの新規登録'
        expect(page).to have_content '管理者画面new'
        fill_in 'user[name]', with: 'bunbun'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: '11111111'
        fill_in 'user[password_confirmation]', with: '11111111'
        click_on '登録'
        expect(page).to have_content 'bunbunのページ'
        # binding.irb
      end

      it '管理ユーザはユーザの詳細画面にアクセスできる' do
        all('#show')[2].click  #user3の詳細ボタン
        sleep 1
        expect(page).to have_content 'Factoryで作ったデフォルトの名前３のページ'
      end

      it '管理ユーザはユーザの編集画面からユーザを編集できる' do
        all('#edit')[2].click  #user3の編集ボタン
        expect(page).to have_content '管理者画面edit'
        fill_in 'user[name]', with: 'bunbun'
        fill_in 'user[email]', with: 'bunbun@mail.com'
        fill_in 'user[password]', with: '11111111'
        fill_in 'user[password_confirmation]', with: '11111111'
        # binding.irb
        click_on '更新'
        # binding.irb
      end

      it '管理ユーザはユーザの削除をできる' do
        page.accept_confirm do
          all('#delete')[2].click  #user3の削除ボタン
        end
        expect(page).to have_content '削除しました！'
      end
    end
  end
end
