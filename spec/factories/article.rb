FactoryBot.define do
  factory :article do
    title {"title test"}
    body {"body test!body test!body test!"}
  end

  factory :article_2, class: "Article" do
    title {"title test2"}
    body {"body test2!body test2!body test!2"}
  end
end