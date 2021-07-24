require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:task2)
    @task3 = FactoryBot.create(:task3)
    # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
    visit tasks_path
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        # 1. new_task_pathに遷移する（新規作成ページに遷移する）
        # ここにnew_task_pathにvisitする処理を書く
        visit new_task_path
        # 2. 新規登録内容を入力する
        #「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄にタスクのタイトルと内容をそれぞれ入力する
        # ここに「タスク名」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[title]', with: 'タスク名を記入'
        # ここに「タスク詳細」というラベル名の入力欄に内容をfill_in（入力）する処理を書く
        fill_in 'task[content]', with: 'タスク詳細を記入'
        # 3. 「登録する」というvalue（表記文字）のあるボタンをクリックする
        # ここに「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
        select '2021', from: 'task[limit(1i)]'
        select '8', from: 'task[limit(2i)]'
        select '1', from: 'task[limit(3i)]'
        select '未着手', from: 'task[status]'
        click_on '登録する'
        # 4. clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
        # （タスクが登録されたらタスク詳細画面に遷移されるという前提）
        # ここにタスク詳細ページに、テストコードで作成したデータがタスク詳細画面にhave_contentされているか（含まれているか）を確認（期待）するコードを書く
        expect(page).to have_content 'タスク名を記入'
        expect(page).to have_content 'タスク詳細を記入'
        expect(page).to have_content '2021-08-01'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        # テストで使用するためのタスクを作成
        task = FactoryBot.create(:task, title: 'task')
        # タスク一覧ページに遷移
        visit tasks_path
        # visitした（遷移した）page（タスク一覧ページ）に「task」という文字列がhave_contentされているか（含まれているか）ということをexpectする（確認・期待する）
        expect(page).to have_content 'task'
        # わざと間違った結果を期待するテストを記載する
        # expect(page).to have_content 'task_failure'
        # expectの結果が true ならテスト成功、false なら失敗として結果が出力される
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        #binding.irb
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content @task3.title
        expect(task_list[1].text).to have_content @task2.title
        expect(task_list[2].text).to have_content @task.title
      end
    end
    context '終了期限でソートした場合' do
      it '終了期限が迫っているタスクが一番上に表示される' do
        click_on '終了期限'
        sleep 1
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content @task3.title
        expect(task_list[1].text).to have_content @task.title
        expect(task_list[2].text).to have_content @task2.title
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
      end
    end
  end
  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        # タスクの検索欄に検索ワードを入力する (例: task)
        fill_in 'title', with: 'タイトル１'
        # 検索ボタンを押す
        click_on '検索'
        sleep 0.5
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        # プルダウンを選択する「select」について調べてみること
        select "未着手", from: 'status'
        click_on '検索'
        sleep 0.5
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content 'Factoryで作ったデフォルトのタイトル２'
        expect(task_list[1].text).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスクが絞り込まれる" do
        # ここに実装する
        fill_in 'title', with: 'タイトル１'
        select "未着手", from: 'status'
        click_on '検索'
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
    context '優先順位検索をした場合' do
      it "優先順位に完全一致するタスクが絞り込まれる" do
        select "中", from: 'priority'
        click_on '検索'
        sleep 0.5
        task_list = all('.task_title')
        expect(task_list[0].text).to have_content 'Factoryで作ったデフォルトのタイトル１'
      end
    end
  end
end
