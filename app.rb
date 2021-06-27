require 'sinatra'
require './memo'
require './memo_repository'
include ERB::Util

# Read

get '/' do
  memo_repo = MemoRepository.new
  @filelists = memo_repo.findAll
  erb :index
end

get '/show/:title' do
  memo = Memo.new(params[:title])
  memo_repo = MemoRepository.new
  data = memo_repo.find(memo)
  @title = data[0][0]
  @text = data[0][1]
  erb :detail
end

# New

get '/new' do
  erb :new
end

post '/new' do
  title = html_escape(params[:title])
  text = html_escape(params[:text])
  memo = Memo.new(title, text)
  memo_repo = MemoRepository.new
  memo_repo.save(memo)
  redirect '/'
end

# Edit

get '/edit/:title' do
  title = html_escape(params[:title])
  memo = Memo.new(title)
  memo_repo = MemoRepository.new
  data = memo_repo.find(memo)
  @title = data[0][0]
  @text = data[0][1]
  erb :edit
end

patch '/edit' do
  memo_repo = MemoRepository.new

  old_title = html_escape(params[:old_title])
  old_text = html_escape(params[:old_text])
  old_memo = Memo.new(old_title, old_text)
  memo_repo.del(old_memo)

  title = html_escape(params[:title])
  text = html_escape(params[:text])
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
