FactoryBot.define do
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル１' }
    content { 'Factoryで作ったデフォルトのコンテント１' }
    limit { '2021-08-02' }
  end
  factory :task2, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル２' }
    content { 'Factoryで作ったデフォルトのコンテント２' }
    limit { '2021-08-03' }
  end
  factory :task3, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル３' }
    content { 'Factoryで作ったデフォルトのコンテント３' }
    limit { '2021-08-01' }
  end
end
