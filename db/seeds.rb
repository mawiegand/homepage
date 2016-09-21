# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create admin user
admin_user = User.new
admin_user.email = 'admin@localhost.localhost'
admin_user.password = '12345678'
admin_user.add_role :admin
admin_user.save!
