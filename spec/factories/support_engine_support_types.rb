# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support_type, class: SupportEngine::SupportType do
    name "Question"
    email "test@test.com"
  end
end
