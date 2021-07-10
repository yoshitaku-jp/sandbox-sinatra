class Memo
  def initialize(uuid = SecureRandom.uuid, title, text)
    @uuid = uuid
    @title = title
    @text = text
  end

  attr_reader :uuid, :title, :text
end
