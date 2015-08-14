require "spec_helper"

module SupportEngine
  RSpec.describe TicketMailer, :type => :mailer do
    let(:type) { double(SupportType, name: "Question", email: "test@supportengine.org") }
    let(:ticket) { double(Ticket, name: "Gabriel", email: "gabriel@text.com", body: "",  title: "Something Wrong", type: type) }
    let(:mail) { TicketMailer.notify(type, ticket) }
    before do
      SupportEngine.configure do|c|
        c.user_class_name = "User"
        c.email_address = nil
        c.email_prefix = nil
      end
    end

    it 'renders the subject' do
      expect(mail.subject).to eql('[SupportEngine][Question] Something Wrong')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([type.email])
    end
  end
end
