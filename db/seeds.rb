# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Role.create([{ name: 'admin', description: 'super access', access_level: 1 },
{name: 'member', description: 'user level', access_level: 2}])

User.create([{ name: 'demo user', email: 'user@demo.com', password: 'password', role_id: 2 },
{name: 'admin user', email: 'user@admin.com', password: 'password', role_id: 1}])
