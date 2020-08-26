# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Like.delete_all 
Comment.delete_all 
Recipe.delete_all
User.delete_all

NUM_RECIPE = 100
NUM_USER = 10
PASSWORD = 'komal'

super_user = User.create(
    first_name: "Komal",
    last_name: "Kainth",
    email: "kk@gmail.com",
    password: PASSWORD, 
    is_admin: true
)


NUM_USER.times do
    first_name = Faker::Name.first_name 
    last_name = Faker::Name.last_name  
    User.create(
        first_name: first_name,
        last_name: last_name,
        email: Faker::Internet.email,
        password: PASSWORD
    )
end

users = User.all

NUM_RECIPE.times do 
    created_at = Faker::Date.backward(days: 365 * 5)
    i = Recipe.create(
        title: Faker::Food.dish,
        body: Faker::Food.description,
        user: users.sample, 
        created_at: created_at,
        updated_at: created_at
    )
    if i.valid? 
        i.comments = rand(0..10).times.map do 
          Comment.new(body: Faker::Lorem.sentence(word_count: 4),user: users.sample)
        end
    end
    i.likers = users.shuffle.slice(0, rand(users.count))

end

recipe = Recipe.all 
comment = Comment.all

puts Cowsay.say("Generated #{Like.count} likes", :apt)
puts Cowsay.say("Generated #{recipe.count} recipes", :calvin)
puts Cowsay.say("Generated #{comment.count} comments", :cheese)
puts Cowsay.say("Generated #{users.count} users", :dragon)