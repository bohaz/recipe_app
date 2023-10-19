FactoryBot.define do
  factory :food do
    name { 'Pear' }
    measurement_unit { 'Kg' }
    price { 1.5 }
    quantity { 10 }
    association :user
  end
end
