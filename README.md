# 起動手順書

- 環境の構築

```
bundle install
rake db:create
rake db:migrate
rails s
```

- テストログインユーザー作成

下記のコマンドを打つことで
ログインID: test_user
パスワード: 12345
でログインすることが出来ます。

```
rake test_user_create:user
```

- .envファイルを作成

ルートディレクトリに「.env」というファイルを作成してください。
作成した.envファイルに環境変数を記述してください。

```
CLIENT_ID = "XXXX"
CLIENT_SECRET = "XXXX"
```
