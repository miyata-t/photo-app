User.create!(
  name: "user_#{User.maximum(:id).to_i + 1}",
  password: "passw0rd"
)
