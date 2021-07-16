# sandbox-sinatra

# 起動方法

## ライブラリインストール

`bundle install` を実行し、ライブラリをインストール

**Ruby 3.0 以降の場合は WEBrick をインストールする必要あり**

## 実行

`docker compose up`でデータベースを起動する。

テーブルを作成する。

```
CREATE DATABASE memos;

CREATE TABLE public.memo (
	uuid uuid NULL,
	title varchar NULL,
	"text" varchar NULL
);
```

`bundle exec ruby app.rb`を実行すると起動
