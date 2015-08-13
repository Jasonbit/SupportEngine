require 'spec_helper'

describe SupportEngine::Configuration do
  subject { SupportEngine.config }

  describe 'user_class' do
    before(:all) do
      SupportEngine.configure {|c| c.user_class_name = "User" }
    end

    it { expect(subject.user_class).to eq(User) }
    it { expect(subject.user_class_name).to eq("User") }
  end
end
