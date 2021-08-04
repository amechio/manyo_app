require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do
  # binding.irb
  before do
    @user = FactoryBot.create(:user)
    @label = FactoryBot.create(:label)
    @label = FactoryBot.create(:label2)
    @label = FactoryBot.create(:label3)
    visit new_session_path
    fill_in 'session[email]', with: 'factory1@mail.com'
    fill_in 'session[password]', with: 'factory1'
    click_on 'ログイン'
  end

  describe '新規作成機能' do
    context 'タスクの新規作成画面に遷移した場合' do
      it 'ラベルのチェックボックスが表示される' do
        # binding.irb
        # @user = FactoryBot.create(:user)
        # @label = FactoryBot.create(:label)
        # @label = FactoryBot.create(:label2)
        # @label = FactoryBot.create(:label3)
        # visit new_session_path
        # fill_in 'session[email]', with: 'factory1@mail.com'
        # fill_in 'session[password]', with: 'factory1'
        # click_on 'ログイン'
        visit new_task_path
        # binding.irb
        expect(page).to have_content '新規作成画面'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル1'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル2'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル3'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '設定したラベルが表示される' do
        # binding.irb
        visit new_task_path
        fill_in 'task[title]', with: 'タスク名を記入'
        fill_in 'task[content]', with: 'タスク詳細を記入'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル3'
        click_on '登録する'

        expect(page).to have_content '一覧画面'
        expect(page).to have_content 'タスク名を記入'
        expect(page).to have_content 'タスク詳細を記入'
        expect(page).to have_content '2021-08-01'
        expect(page).to have_content '未着手'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル1'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル3'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '設定したラベルが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'タスク名を記入'
        fill_in 'task[content]', with: 'タスク詳細を記入'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル3'
        click_on '登録する'

        # binding.irb
        all('.option_btn')[0].click  #taskの詳細ボタン
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル1'
        expect(page).to have_content 'Factoryで作ったデフォルトのラベル3'
      end
    end
  end

  describe '検索機能' do
    context 'ラベル検索をした場合' do
      it '検索したラベルを含むタスクが絞り込まれる' do
        # binding.irb
        visit new_task_path
        fill_in 'task[title]', with: '検索用タスク名1'
        fill_in 'task[content]', with: '検索用タスク詳細1'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル3'
        click_on '登録する'

        visit new_task_path
        fill_in 'task[title]', with: '検索用タスク名2'
        fill_in 'task[content]', with: '検索用タスク詳細2'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル2'
        click_on '登録する'

        visit tasks_path
        # binding.irb
        # fill_in 'title', with: 'タイトル１'
        select "Factoryで作ったデフォルトのラベル3", from: 'label_id'
        click_on '検索'
        # task_list = all('.task_title')
        expect(page).to have_content '検索用タスク名1'
        expect(page).to_not have_content '検索用タスク名2'
        # expect(task_list[0].text).to eq 'タスク名1'
      end
    end

    context 'タイトルのあいまい検索とラベル検索をした場合' do
      it ' 検索キーワードをタイトルに含み、かつ検索したラベルを含むタスクが絞り込まれる' do
        visit new_task_path
        fill_in 'task[title]', with: '検索用タスク名1'
        fill_in 'task[content]', with: '検索用タスク詳細1'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル3'
        click_on '登録する'

        visit new_task_path
        fill_in 'task[title]', with: '検索用タスク名2'
        fill_in 'task[content]', with: '検索用タスク詳細2'
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        check 'Factoryで作ったデフォルトのラベル1'
        check 'Factoryで作ったデフォルトのラベル3'
        click_on '登録する'

        visit tasks_path
        # binding.irb
        fill_in 'title', with: '検索用タスク名1'
        select "Factoryで作ったデフォルトのラベル1", from: 'label_id'
        click_on '検索'
        expect(page).to have_content '検索用タスク名1'
        expect(page).to_not have_content '検索用タスク名2'
      end
    end
  end
end
