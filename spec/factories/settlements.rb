FactoryBot.define do
  factory :settlement do
    owed_by { 1 }
    owed_to { 1 }
    amount { 1 }
  end
end
