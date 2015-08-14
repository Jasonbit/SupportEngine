require 'spec_helper'

describe SupportEngine::Configuration do
  subject { SupportEngine.config }

  describe 'user_class' do
    context "defaul values" do
      before do
        SupportEngine.configure do|c|
          c.user_class_name = "User"
          c.email_address = nil
          c.email_prefix = nil
        end
      end
      it { expect(subject.email_prefix).to eq("SupportEngine") }
      it { expect(subject.email_address).to eq("no-reply@supportengine.org") }
    end

    context "value" do
      before do
        SupportEngine.configure do|c|
          c.user_class_name = "User"
          c.email_address = "no-reply@test.com"
          c.email_prefix = "Test"
        end
      end
      it { expect(subject.user_class).to eq(User) }
      it { expect(subject.user_class_name).to eq("User") }
      it { expect(subject.email_address).to eq("no-reply@test.com") }
      it { expect(subject.email_prefix).to eq("Test") }
    end
  end
end
