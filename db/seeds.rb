user = User.create!(
  name: "user_#{User.maximum(:id).to_i + 1}",
  password: "passw0rd"
)

puts "####作成したユーザー####"
puts "ユーザーID: #{user.name}"
puts "パスワード: passw0rd"
