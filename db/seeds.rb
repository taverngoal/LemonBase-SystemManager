# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'windack@qq.com', password: '19901001', nick: 'tavern', password_confirmation: '19901001', name: 'Tavern')
App.create(name: :'LemonBase', permission_level: 100, enable: true)