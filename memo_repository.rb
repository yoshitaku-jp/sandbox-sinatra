require './memo'
require 'pg'

class MemoRepository
  def initialize; end

  def get_connection
    connection = PG.connect(host: ENV['HOST_SINATRA'], user: ENV['USER_SINATRA'], password: ENV['PASSWORD_SINATRA'], dbname: ENV['DBNAME_SINATRA'],
                            port: ENV['PORT_SINATRA'])
  end

  def find_all
    connection = get_connection
    result = connection.exec('SELECT uuid, title,text FROM memo')
    memos = []
    result.map { |memo| memos << Memo.new(memo['uuid'], memo['title'], memo['text']) }
    memos
  ensure
    connection = nil
  end

  def find(filename)
    connection = get_connection
    result = connection.exec('SELECT title,text FROM memo WHERE uuid = $1', [filename])
    memo = nil
    result.each do |cur|
      memo = Memo.new(cur['title'], cur['text'])
    end
    memo
  end

  def save(memo)
    connection = get_connection
    connection.exec('INSERT INTO memo (uuid,title,text) VALUES ($1, $2, $3)', [memo.uuid, memo.title, memo.text])
  ensure
    connection = nil
  end

  def update(_filename)
    connection = get_connection
    connection.exec('UPDATE memo SET title = $2,text = $3 WHERE uuid = $1', [memo.uuid, memo.title, memo.text])
  ensure
    connection = nil
  end

  def del(filename)
    connection = get_connection
    connection.exec('DELETE FROM memo WHERE uuid = $1', [filename])
  ensure
    connection = nil
  end
end
