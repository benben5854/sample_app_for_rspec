FactoryBot.define do
  factory :task do
    title { "test-title" }
    content { "test-content" }
    status { 0 }
    association :user
  end
end
