FactoryBot.define do
  factory :wiki do
    title RandomData.random_sentence
    body RandomData.random_paragraph
    user
    rank 0.0
  end
end
