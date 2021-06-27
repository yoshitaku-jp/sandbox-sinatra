require './memo'
require 'csv'

class MemoRepository
  def initialize
    @directory = './database/'
  end

  def find_all
    filelists = Dir.children(@directory)
    filelists.map { |filename| filename.split('.')[0] }
  end

  def find(memo)
    CSV.read("#{@directory}#{memo.title}.csv")
  end

  def save(memo)
    CSV.open("#{@directory}#{memo.title}.csv", 'w') { |csv| csv << [memo.title, memo.text] }
  end

  def del(memo)
    File.delete("#{@directory}#{memo.title}.csv")
  end
end
