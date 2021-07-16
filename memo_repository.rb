require './memo'
require 'pg'

class MemoRepository
  def initialize; end

  def find_all
    connection = PG.connect(host: 'localhost', user: 'admin', password: 'admin', dbname: 'memos',
                            port: '15432')
    result = connection.exec('SELECT uuid, title,text FROM memo')

    memos = []
    result.each do |memo|
      memos << Memo.new(memo['uuid'], memo['title'], memo['text'])
    end
    memos
  end

  def find(filename)
    connection = PG.connect(host: 'localhost', user: 'admin', password: 'admin', dbname: 'memos', port: '15432')
    result = connection.exec('SELECT title,text FROM memo WHERE uuid = $1', [filename])
    memo = nil
    result.each do |cur|
      memo = Memo.new(cur['title'], cur['text'])
    end
    memo
  end

  def save(memo)
    connection = PG.connect(host: 'localhost', user: 'admin', password: 'admin', dbname: 'memos', port: '15432')
    connection.exec('INSERT INTO memo (uuid,title,text) VALUES ($1, $2, $3)', [memo.uuid, memo.title, memo.text])
  end

  def update(_filename)
    connection = PG.connect(host: 'localhost', user: 'admin', password: 'admin', dbname: 'memos', port: '15432')
    connection.exec('UPDATE memo SET title = $2,text = $3 WHERE uuid = $1', [memo.uuid, memo.title, memo.text])
  end

  def del(filename)
    connection = PG.connect(host: 'localhost', user: 'admin', password: 'admin', dbname: 'memos', port: '15432')
    connection.exec('DELETE FROM memo WHERE uuid = $1', [filename])
  end
end
