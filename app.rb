require 'sinatra'
require './memo'
require './memo_repository'

get '/' do
    memo_repo = MemoRepository.new()
    @filelists = memo_repo.findAll()
    erb :index
end

get '/show/:title' do
    memo = Memo.new(params[:title])
    memo_repo = MemoRepository.new()
    data = memo_repo.find(memo)
    @title = data[0][0]
    @text = data[0][1]
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
    redirect '/'
end
get '/edit/:title' do
    memo = Memo.new(params[:title])
    memo_repo = MemoRepository.new()
    data = memo_repo.find(memo)
    @title = data[0][0]
    @text = data[0][1]
    erb :edit
end

patch '/edit' do
    memo_repo = MemoRepository.new()

    old_memo = Memo.new(params[:old_title], params[:old_text])
    memo_repo.del(old_memo)

    memo = Memo.new(params[:title], params[:text])
    memo_repo.save(memo)
    erb :edit
end
delete '/delete/:title' do
    memo = Memo.new(params[:title])
    memo_repo = MemoRepository.new()
    memo_repo.del(memo)
    redirect '/'
end

# 404

not_found do
    erb :not_found
end