module SupportEngine
  class Ticket < ActiveRecord::Base
    include TicketStates::Checker

    attr_accessible :title, :name, :email, :user_id, :assignee_id

    belongs_to :user,      class_name: SupportEngine.config.user_class_name
    belongs_to :assignee,  class_name: SupportEngine.config.user_class_name

    validates :title,  presence: true
    validates :state,  presence: true,
      inclusion: SupportEngine::TicketStates.state_keys

    validates :name, :email, presence: true, if: ->(t) { t.user.blank? }

    def to_json(options = {})
      super(methods: [:url])
    end
    # this method is called for each instance in an Array to avoid circular references.
    def as_json(options = {})
      super(methods: [:url])
    end

    def url
      SupportEngine::Engine.routes.url_helpers.api_v1_ticket_path(self)
    end
  end
end
