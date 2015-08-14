require "spec_helper"

module SupportEngine
  RSpec.describe TicketMailer, :type => :mailer do
    let(:type) { double(SupportType, name: "Question", email: "test@supportengine.org") }
    let(:ticket) { double(Ticket, name: "Gabriel", email: "gabriel@text.com", body: "",  title: "Something Wrong", type: type) }
    let(:mail) { TicketMailer.notify(type, ticket) }

    it 'renders the subject' do
      expect(mail.subject).to eql('[SupportEngine][Question] Something Wrong')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([type.email])
    end
  end
end
