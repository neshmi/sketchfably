require "sketchfably/version"
require 'rest_client'

module Sketchfably
  def self.get_models_by_tag(tag)
    results = RestClient.get "https://api.sketchfab.com/v2/models?tags_filter=#{tag}"
    json_results = JSON.parse results
    models = []
    json_results["results"].map{|result| models << {id: result["uid"], name: result["name"], username: result["user"]["username"]}}
    return models
  end

  def self.get_html_for_model(model_hash)
    html = <<-eol
<iframe width="640" height="480" src="https://sketchfab.com/models/#{model_hash[:id]}/embed" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" onmousewheel=""></iframe>

<p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;">
  <a href="https://sketchfab.com/models/#{model_hash[:id]}?utm_source=oembed&utm_medium=embed&utm_campaign=#{model_hash[:id]}" target="_blank" style="font-weight: bold; color: #1CAAD9;">#{model_hash[:name]}</a>
  by <a href="https://sketchfab.com/neshmi?utm_source=oembed&utm_medium=embed&utm_campaign=#{model_hash[:id]}" target="_blank" style="font-weight: bold; color: #1CAAD9;">#{model_hash[:username]}</a>
  on <a href="https://sketchfab.com?utm_source=oembed&utm_medium=embed&utm_campaign=#{model_hash[:id]}" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a>
</p>
    eol
  end
end
