require 'spec_helper'

module SupportEngine
  RSpec.describe Comment, :type => :model do
    context "Validations" do
      it "validates content" do
        comment = Comment.new
        expect(comment).to be_invalid
        expect(comment.errors[:content]).to_not be_blank
      end

      it "validates ticket" do
        comment = Comment.new
        expect(comment).to be_invalid
        expect(comment.errors[:ticket_id]).to_not be_blank

        comment = Comment.new(ticket_id: 1)
        expect(comment).to be_invalid
        expect(comment.errors[:ticket_id]).to be_blank
      end
    end
  end
end
