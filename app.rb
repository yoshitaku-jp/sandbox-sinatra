require 'sinatra'
require './memo'
require './memo_repository'
require './helpers/helpers'


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

get '/edit/:filename' do
  memo_repo = MemoRepository.new
  memo = memo_repo.find(params[:filename])
  @filename = params[:filename]
  @title = memo[0][0]
  @text = memo[0][1]
  erb :edit
end

patch '/edit' do
  memo_repo = MemoRepository.new

  # 削除処理
  memo_repo.del(params[:filename])

  # 新規作成処理
  title = params[:title]
  text = params[:text]
  memo = Memo.new(title, text)
  memo_repo.save(memo)

  erb :edit
end

# Delete

delete '/delete/:title' do
  memo_repo = MemoRepository.new
  memo_repo.del(params[:filename])
  redirect '/'
end

# 404

not_found do
  erb :not_found
end
