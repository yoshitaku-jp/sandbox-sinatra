require './memo'
require 'csv'

class MemoRepository
  def initialize
    @directory = './database/'
  end

  def find_all
    dir_files = Dir.children(@directory)

    files = []
    dir_files.each do |file|
      next if file[0] == '.'

      file_info = []
      file_info << file.split('.')[0]

      data = CSV.read("#{@directory}#{file}")
      file_info << data[0][0]
      files << file_info
    end
    files
  end

  def find(filename)
    CSV.read("#{@directory}#{filename}.csv")
  end

  def save(memo)
    CSV.open("#{@directory}#{memo.uuid}.csv", 'w') { |csv| csv << [memo.title, memo.text] }
  end

  def del(filename)
    File.delete("#{@directory}#{filename}.csv")
  end
end
