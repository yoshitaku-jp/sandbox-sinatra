require './memo'
require "csv"


class MemoRepository
    
    def initialize
        @directory = './database/'
    end

    def findAll
        filelists = Dir.children(@directory)
        filelists = filelists.map{|filename| filename.split('.')[0]}
        filelists
    end
        
    end

    def save(memo)
        CSV.open(@directory + memo.getTitle + '.csv', 'w'){ |csv|
            csv << [memo.getTitle,memo.getText]
          }
    end

    def del(memo)
        File.delete(@directory + memo.getTitle + '.csv')
    end
end