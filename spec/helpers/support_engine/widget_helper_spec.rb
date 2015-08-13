require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the WidgetHelper. For example:
#
# describe WidgetHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
module SupportEngine
  RSpec.describe WidgetHelper, :type => :helper do

    it 'renders the datatable partial' do
      expect(support_engine_widget).to match(/form/)
    end
  end
end
