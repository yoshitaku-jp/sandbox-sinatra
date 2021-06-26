require './memo'
require "csv"


class MemoRepository
    
    def initialize
        @directory = './database/'
    end

    def findAll
        
    end

    def save(memo)
        CSV.open(@directory + memo.getTitle + '.csv', 'w'){ |csv|
            csv << [memo.getTitle,memo.getText]
          }
    end

end