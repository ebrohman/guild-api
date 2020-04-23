# frozen_string_literal: true

kim = User.find_or_create_by!(name: "Kim", email: "kim@guild.com", settings: {})
valerie = User.find_or_create_by!(name: "Valerie", email: "valerie@guild.com", settings: {})

ENV.fetch("NUM_MESSAGES", 100).to_i.times do |i|
  if i.even?
    Message.create(sender: valerie, recipient: kim, body: Faker::Movies::HarryPotter.quote)
  else
    Message.create(sender: kim, recipient: valerie, body: Faker::Movies::HarryPotter.quote)
  end
end
