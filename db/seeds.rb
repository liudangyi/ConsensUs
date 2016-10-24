# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

daniel = User.create!(name: 'Daniel', email: 'daniel@ucsd.edu', password: '123456')

decision = Decision.create!(name: 'FirstDecision', description: 'Our first decision', owner: daniel)

%w[ James Mary Paul Linda Dave ].each do |e|
  Candidate.new(name: e, decision: decision)
end

['Academic', 'Recommendation Letter', 'Readiness for Engineering'].each do |e|
  Criterium.new(name: e, decision: decision)
end
