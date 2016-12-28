FactoryGirl.define do
  factory :platform1, class: Favorito::Platform do
    name :github
    username 'beck03076'
    options per_page: 10

    initialize_with { new(name, username, options) }
  end
end
