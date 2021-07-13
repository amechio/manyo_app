# README

# Hrokuデプロイ手順
①Herokuにログインする
```
$ heroku login -i
```
②Herokuにデプロイしたいアプリケーションにいることを確認
③Herokuに新しいアプリケーションを作成
```
$ heroku create
```
④アセットプリコンパイルをする
```
$ rails assets:precompile RAILS_ENV=production
```
⑤bundle installを実行
```
$ bundle install
```
⑥コミットする
```
$ git add -A
$ git commit -m "コミットメッセージ"
```
⑦Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
⑧Herokuにプッシュする
```
$ git push heroku master
```
⑨マイグレーションを実行
```
$ heroku run rails db:migrate
```
