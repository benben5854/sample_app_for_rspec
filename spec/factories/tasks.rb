FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "test-title_#{n}" }
    content { "test-content" }
    status { 0 }
    association :user
  end
end
