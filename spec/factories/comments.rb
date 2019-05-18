FactoryBot.define do
  factory :comment do
    user
    body_markdown      { Faker::Hipster.paragraph(1) }
    commentable_id     { rand(1000) }
    commentable_type   { "Article" }
    factory :article_comment do
      association :commentable, factory: :article
    end

    trait :with_mention do
      after(:create) do |comment|
        Mention.create_all_without_delay(comment)
      end
    end
  end
end
