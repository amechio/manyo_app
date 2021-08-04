
User.create!(
  [
    { name: '管理人1', email: 'kanri1@mail.com', password: 'password', password_confirmation: 'password', admin: true }
  ]
)

(2..10).each do |i|
  User.create!(
    name: "初期ユーザ#{i}",
    email: "user#{i}@mail.com",
    password: 'password',
    password_confirmation: 'password',
    admin: false
  )
end

10.times do |i|
  title = "初期タスク#{i}"
  content = "初期タスク#{i}"
  from = Date.parse("2021/08/01")
  to = Date.parse("2021/08/31")
  limit = rand(from..to)
  status = rand(0..2)
  priority = rand(0..2)
  user_id = rand(1..10)
  Task.create!(
    title: title,
    content: content,
    limit: limit,
    status: status,
    priority: priority,
    user_id: user_id
  )
end

Label.create!(
  [
    { name: '初期ラベル1' },
    { name: '初期ラベル2' },
    { name: '初期ラベル3' },
    { name: '初期ラベル4' },
    { name: '初期ラベル5' },
    { name: '初期ラベル6' },
    { name: '初期ラベル7' },
    { name: '初期ラベル8' },
    { name: '初期ラベル9' },
    { name: '初期ラベル10' }
  ]
)
