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
    CSV.read("#{@directory}#{memo.getTitle}.csv")
  end

  def save(memo)
    CSV.open("#{@directory}#{memo.getTitle}.csv", 'w') { |csv| csv << [memo.getTitle, memo.getText] }
  end

  def del(memo)
    File.delete("#{@directory}#{memo.getTitle}.csv")
  end
end
