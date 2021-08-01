FactoryBot.define do
  factory :label do
    # association :task
    id { 0 }
    name { 'Factoryで作ったデフォルトのラベル1' }
  end

  factory :label2, class: Label do
    # association :user
    id { 1 }
    name { 'Factoryで作ったデフォルトのラベル2' }
    # task_id { Task.first.id }
  end

  factory :label3, class: Label do
    # association :user
    id { 2 }
    name { 'Factoryで作ったデフォルトのラベル3' }
    # task_id { Task.first.id }
  end
end
