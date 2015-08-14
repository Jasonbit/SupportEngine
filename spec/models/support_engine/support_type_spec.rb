require 'spec_helper'

module SupportEngine
  RSpec.describe SupportType, :type => :model do
    subject { FactoryGirl.create(:support_type) }
    let(:ticket) { double(Ticket, name: "Gabriel", email: "gabriel@text.com", body: "",  title: "Something Wrong") }
    it "notify" do
      ActionMailer::Base.deliveries = []
      expect { subject.notify!(ticket) }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
