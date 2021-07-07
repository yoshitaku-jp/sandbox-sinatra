require 'sinatra'
require './memo'
require './memo_repository'

# Read

get '/' do
  memo_repo = MemoRepository.new
  @files = memo_repo.find_all
  erb :index
end

get '/show/:filename' do
  memo_repo = MemoRepository.new
  memo = memo_repo.find(params[:filename])
  @filename = params[:filename]
  @title = memo[0][0]
  @text = memo[0][1]
  erb :detail
end

# New

get '/new' do
  erb :new
end

post '/new' do
  title = params[:title]
  text = params[:text]
  memo = Memo.new(title, text)
  memo_repo = MemoRepository.new
  memo_repo.save(memo)
  redirect '/'
end

# Edit

get '/edit/:title' do
  title = params[:title]
  memo = Memo.new(title)
  memo_repo = MemoRepository.new
  data = memo_repo.find(memo)
  @title = data[0][0]
  @text = data[0][1]
  erb :edit
end

patch '/edit' do
  memo_repo = MemoRepository.new

  old_title = params[:old_title]
  old_text = params[:old_text]
  old_memo = Memo.new(old_title, old_text)
  memo_repo.del(old_memo)

  title = params[:title]
  text = params[:text]
  memo = Memo.new(title, text)
  memo_repo.save(memo)
  erb :edit
end

# Delete

delete '/delete/:title' do
  memo = Memo.new(params[:title])
  memo_repo = MemoRepository.new
  memo_repo.del(memo)
  redirect '/'
end

# 404

not_found do
  erb :not_found
end
