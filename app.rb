require 'sinatra'
require './memo'
require './memo_repository'

get '/' do
    hash = {"id":1,"title": "メモ","text": "コレはメモの中身です"}
    @id = hash[:id]
    @title = hash[:title]
    erb :index
end

get '/show/:id' do
    hash = {"id":1,"title": "メモ","text": "コレはメモの中身です"}
    @title = hash[:title]
    @text = hash[:text]
    erb :detail
end

get '/new' do
    p "new get"
    erb :new
end

post '/new' do
    p "new post"
    memo = Memo.new(params[:title], params[:text])
    memo_repo = MemoRepository.new()
    memo_repo.save(memo)
    erb :new
end

post '/delete' do
    p "delete post"
    memo = Memo.new(params[:title], params[:text])
    memo_repo = MemoRepository.new()

# 404

not_found do
    erb :not_found
end