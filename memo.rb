class Memo
  def initialize(title, text = '')
    @title = title
    @text = text
  end

  attr_reader :title, :text
end
