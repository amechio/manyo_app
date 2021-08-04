FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    limit { '2021-08-02' }
    status { '未着手' }
    priority { '中' }
    association :user
  end

  factory :task2, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    limit { '2021-08-03' }
    status { '未着手' }
    priority { '低' }
    user_id { User.first.id }
  end

  factory :task3, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    limit { '2021-08-01' }
    status { '着手中' }
    priority { '低' }
    user_id { User.first.id }
  end
end
