module SupportEngine
  class TicketMailer < ActionMailer::Base
    default from: "no-reply@#{SupportEngine.config.email_address}"

    def notify(type, ticket)
      @ticket = ticket
      @type = type
      @subject = "[#{type.name}] #{ticket.title}"
      @subject = "[#{SupportEngine.config.email_prefix}]#{@subject}" if SupportEngine.config.email_prefix

      mail(:to => type.email, :subject => @subject)
    end
  end
end
