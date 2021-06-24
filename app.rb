require 'sinatra'

get '/' do
    hash = {"id":1,"title": "メモ","text": "コレはメモの中身です"}
    @id = hash[:id]
    @title = hash[:title]
    erb :index
end

get '/:id' do
    hash = {"id":1,"title": "メモ","text": "コレはメモの中身です"}
    @title = hash[:title]
    @text = hash[:text]
    erb :detail
end