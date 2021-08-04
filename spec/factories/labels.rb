FactoryBot.define do
  factory :label do
    name { 'Factoryで作ったデフォルトのラベル1' }
  end

  factory :label2, class: Label do
    name { 'Factoryで作ったデフォルトのラベル2' }
  end

  factory :label3, class: Label do
    name { 'Factoryで作ったデフォルトのラベル3' }
  end
end
