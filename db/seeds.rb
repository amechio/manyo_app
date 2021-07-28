User.create!(
  name: "管理人1",
  email: "user1@mail.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)
User.create!(
  name: "初期ユーザ2",
  email: "user2@mail.com",
  password: "password",
  password_confirmation: "password",
  admin: false
)
User.create!(
  name: "初期ユーザ",
  email: "user3@mail.com",
  password: "password",
  password_confirmation: "password",
  admin: false
)

User.all.each do |user|
  user.tasks.create!(
    title: "いっこめ",
    content: "いっこめ",
    limit: "2021-08-02",
    status: "未着手",
    priority: "高",
  )
  user.tasks.create!(
    title: "にこめ",
    content: "にこめ",
    limit: "2021-08-03",
    status: "着手中",
    priority: "中",
  )
  user.tasks.create!(
    title: "さんこめ",
    content: "さんこめ",
    limit: "2021-08-01",
    status: "完了",
    priority: "低",
  )
end
