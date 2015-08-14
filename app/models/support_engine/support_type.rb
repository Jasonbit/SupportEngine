module SupportEngine
  class SupportType < ActiveRecord::Base
    attr_accessible :name, :email

    has_many :tickets, inverse_of: :support_type

    # TODO: Detect background job
    def notify!(ticket)
      SupportEngine::TicketMailer.notify(self, ticket).deliver
    end
  end
end
