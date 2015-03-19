class SketchfabModel
  attr_accessor :name, :username, :id
  def initialize(name:, id:, username:)
    @id = id
    @name = name
    @username = username
  end

  def html(height: 480, width: 640)
    Sketchfably.get_html_for_model(sketchfab_model: self, height: height, width: width)
  end
end