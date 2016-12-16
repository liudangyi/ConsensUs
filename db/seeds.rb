# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

dangyi = User.find_or_create_by!(name: 'Dangyi', email: 'dangyi@ucsd.edu', password: '123456')
weichen = User.find_or_create_by!(name: 'Weichen', email: 'weichen@ucsd.edu', password: '123456')
steven = User.find_or_create_by!(name: 'Steven', email: 'steven@ucsd.edu', password: '123456')

decision = Decision.find_or_create_by!(name: 'FirstDecision', description: 'Our first decision', visibility: :private)

Membership.find_or_create_by!(user: dangyi, decision: decision, role: :owner)
Membership.find_or_create_by!(user: weichen, decision: decision, role: :member)
Membership.find_or_create_by!(user: steven, decision: decision, role: :member)

Alternative.destroy_all
Criterium.destroy_all
Score.destroy_all

%w[ James Mary Paul Linda ].each do |e|
  Alternative.create!(name: e, decision: decision)
end

['Academic', 'Recommendation Letter', 'Readiness for Engineering'].each do |e|
  Criterium.create!(name: e, decision: decision)
end

Alternative.each do |a|
  Criterium.each do |c|
    Membership.each do |u|
      Score.create(membership: u, value: rand(100)/10.0, alternative: a, criterium: c)
    end
  end
end
