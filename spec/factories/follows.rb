# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :follow, :class => 'Follows' do
    user nil
    espace nil
  end
end
