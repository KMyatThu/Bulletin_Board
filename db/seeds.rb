# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: 'user01',
            email:'user01@gmail.com',
            password: "1234",
            profile: "user01.jpg",
            role: 1,
            phone: "09254312",
            address: "Insein",
            dob: "2021-04-01",
            create_user_id: 1,
            updated_user_id: 1,
            updated_at: Time.now
          )