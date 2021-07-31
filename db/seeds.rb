
User.create!(
  [
    { name: '管理人1', email: 'user1@mail.com', password: 'password', password_confirmation: 'password', admin: true },
    { name: '初期ユーザ2', email: 'user2@mail.com', password: 'password', password_confirmation: 'password', admin: false },
    { name: '初期ユーザ3', email: 'user3@mail.com', password: 'password', password_confirmation: 'password', admin: false }
  ]
)

Task.create!(
  [
    { title: 'いっこめ', content: 'いっこめ', limit: '2021-08-02', status: '未着手', priority: '高', user_id: 1 },
    { title: 'にこめ', content: 'にこめ', limit: '2021-08-03', status: '着手中', priority: '中', user_id: 2 },
    { title: 'さんこめ', content: 'さんこめ', limit: '2021-08-01', status: '完了', priority: '低', user_id: 3 }
  ]
)

Label.create!(
  [
    { name: '初期ラベル1' },
    { name: '初期ラベル2' },
    { name: '初期ラベル3' },
    { name: '初期ラベル4' },
    { name: '初期ラベル5' },
  ]
)
