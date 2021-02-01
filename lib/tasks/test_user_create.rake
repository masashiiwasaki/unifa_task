namespace :test_user_create do
  desc "テストユーザーの作成"
  task user: :environment do
    User.create(uid: "test_user", password: "12345")
  end
end
