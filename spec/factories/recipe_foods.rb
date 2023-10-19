FactoryBot.define do
  factory :recipe_food do
    quantity { Faker::Number.decimal(l_digits: 2) }  
    association :recipe  
    association :food    
  end
end
