# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :support_engine_support_type, :class => 'SupportType' do
    name "MyString"
  end
end
