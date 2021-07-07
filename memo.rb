class Memo
  def initialize( title, text = '')
    @uuid = SecureRandom.uuid
    @title = title
    @text = text
  end

  attr_reader :uuid, :title, :text
end
