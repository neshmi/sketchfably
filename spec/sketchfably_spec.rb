require 'spec_helper'

describe Sketchfably do
  describe "tag query" do
    subject { Sketchfably.get_models_by_tag("proejctmosul") }

    its(:size){ should eq(1) }
  end

  describe "tag query models" do
    subject { Sketchfably.get_models_by_tag("projectmosul").first }

    its([:id]){ should eq("55ea0aed9bfd462593f006ea8c4aade0") }
    its([:username]){ should eq("neshmi") }
    its([:name]){ should eq("The Lion of Mosul") }
  end

  describe "html template" do
    def model
      Sketchfably.get_models_by_tag("projectmosul").first
    end

    def html_template
      File.read(File.join(File.dirname(__FILE__),"fixtures","embed_code"))
    end
    
    it "should render html for a model" do
      expect(Sketchfably.get_html_for_model model).to eq(html_template)
    end
  end
end