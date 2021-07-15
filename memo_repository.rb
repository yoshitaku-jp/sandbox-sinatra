require './memo'
require 'csv'

class MemoRepository
  def initialize
    @directory = './database/'
  end

  def find_all
    dir_csvs = Dir.glob("#{@directory}*.csv")

    memos = []
    dir_csvs.each do |file|
      memo = nil
      filename = File.basename(file, '.csv')
      CSV.foreach(file) do |row|
        memo = Memo.new(filename, row[0], row[1])
      end
      memos << memo
    end
    memos
  end

  def find(filename)
    memo = ''
    CSV.foreach("#{@directory}#{filename}.csv") do |row|
      memo = Memo.new(row[0], row[1])
    end
    memo
  end

  def save(memo)
    CSV.open("#{@directory}#{memo.uuid}.csv", 'w') { |csv| csv << [memo.title, memo.text] }
  end

  def del(filename)
    File.delete("#{@directory}#{filename}.csv")
  end
end
