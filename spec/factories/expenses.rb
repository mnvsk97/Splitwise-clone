FactoryBot.define do
  factory :expense do
    paid_by { 1 }
    amount { 1 }
    paid_for { 1 }
    distribution_type { 1 }
    created_by { 1 }
  end
end
