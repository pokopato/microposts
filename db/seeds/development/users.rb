names = %w(Taro Jiro Hana John Mike Sophy Bill Alex Mary Tom)

0.upto(9) do |idx|
  User.create(
    name: names[idx],
    email: "#{names[idx]}@example.com",
    password: 'password'
  )
end