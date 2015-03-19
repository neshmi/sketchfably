require File.dirname(__FILE__) + '/sketchfably/version'
require File.dirname(__FILE__) + '/sketchfably/sketchfab_model'

require 'net/http'
require 'uri'

module Sketchfably
  def self.get_models_by_tag(tag)
    uri = URI.parse("https://api.sketchfab.com/v2/models?tags_filter=#{tag}")
    response = Net::HTTP.get_response(uri)
    json_results = JSON.parse response.body
    models = []
    json_results["results"].map{|result| models << ::SketchfabModel.new(id: result["uid"], name: result["name"], username: result["user"]["username"])}
    return models
  end

  def self.get_model_from_bbcode(bbcode)
    ## [sketchfab]55ea0aed9bfd462593f006ea8c4aade0[/sketchfab]
      #[url=https://sketchfab.com/models/55ea0aed9bfd462593f006ea8c4aade0]The Lion of Mosul[/url] by [url=https://sketchfab.com/neshmi]neshmi[/url] on [url=https://sketchfab.com]Sketchfab[/url]
    bbcode.match(/\[sketchfab\](.*)\[\/sketchfab\]\s\[url.*\](.*)\[\/url\].*\[url.*\](.*)\[\/url\].*\[url.*\](.*)\[\/url\]/)
    model = SketchfabModel.new(id: $1, name: $2, username: $3)
    return model
  end

  def self.get_html_for_model(sketchfab_model)
    html = <<-eol
<iframe width="640" height="480" src="https://sketchfab.com/models/#{sketchfab_model.id}/embed" frameborder="0" allowfullscreen mozallowfullscreen="true" webkitallowfullscreen="true" onmousewheel=""></iframe>

<p style="font-size: 13px; font-weight: normal; margin: 5px; color: #4A4A4A;">
  <a href="https://sketchfab.com/models/#{sketchfab_model.id}?utm_source=oembed&utm_medium=embed&utm_campaign=#{sketchfab_model.id}" target="_blank" style="font-weight: bold; color: #1CAAD9;">#{sketchfab_model.name}</a>
  by <a href="https://sketchfab.com/neshmi?utm_source=oembed&utm_medium=embed&utm_campaign=#{sketchfab_model.id}" target="_blank" style="font-weight: bold; color: #1CAAD9;">#{sketchfab_model.username}</a>
  on <a href="https://sketchfab.com?utm_source=oembed&utm_medium=embed&utm_campaign=#{sketchfab_model.id}" target="_blank" style="font-weight: bold; color: #1CAAD9;">Sketchfab</a>
</p>
    eol
  end
end
