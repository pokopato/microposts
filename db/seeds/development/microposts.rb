
%w(Taro Jiro Hana).each do |name|
  user = User.find_by(name: name)
  0.upto(9) do |idx|
    Micropost.create(
      user: user,
      content: "hogehoge #{idx}",
      created_at: 10.days.ago.advance(days: idx),
    )
  end
end

