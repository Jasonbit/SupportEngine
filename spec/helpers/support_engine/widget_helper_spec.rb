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

    def current_user
      "this"
    end

    context "current_user" do
      it "with a method returns the current user" do
        SupportEngine.configure {|c| c.current_user_method = "current_user" }
        expect(support_engine_current_user).to eq(current_user)
      end

      it "without a method return nil" do
        SupportEngine.configure {|c| c.current_user_method = nil }
        expect(support_engine_current_user).to eq(nil)
      end
    end
  end
end
