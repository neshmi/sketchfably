class SketchfabModel
  attr_accessor :name, :username, :id
  def initialize(name:, id:, username:)
    @id = id
    @name = name
    @username = username
  end

  def html
    Sketchfably.get_html_for_model(self)
  end
end