# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

daniel = User.find_or_create_by!(name: 'Daniel', email: 'daniel@ucsd.edu', password: '123456')

decision = Decision.find_or_create_by!(name: 'FirstDecision', description: 'Our first decision', visibility: :private)

Membership.find_or_create_by!(user: daniel, decision: decision, role: :owner)

%w[ James Mary Paul Linda Dave ].each do |e|
  Alternative.create!(name: e, decision: decision)
end

['Academic', 'Recommendation Letter', 'Readiness for Engineering'].each do |e|
  Criterium.create!(name: e, decision: decision)
end
