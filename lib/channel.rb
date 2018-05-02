class Channel
  attr_reader :name, :id

  def initialize(name, id, options = {})
    @name = name
    @id = id

  end
end
