module SupportEngine
  class Ticket < ActiveRecord::Base
    include TicketStates::Checker

    attr_accessible :title, :name, :email, :user_id, :assignee_id, :body,
      :support_type_id, :state, :priority

    belongs_to :user,      class_name: SupportEngine.config.user_class_name
    belongs_to :assignee,  class_name: SupportEngine.config.user_class_name

    belongs_to :support_type, inverse_of: :tickets

    has_many :comments

    validates :title,         presence: true
    validates :support_type,  presence: true
    validates :state,         presence: true,
      inclusion: SupportEngine::TicketStates.state_keys

    validates :priority, presence: true,
      inclusion: SupportEngine::TicketPriority.priorities_keys

    validates :name, :email, presence: true, if: ->(t) { t.user.blank? }

    after_create :notify_support_group

    delegate :name,  to: :support_type,  prefix: true
    delegate :name,  to: :assignee,      prefix: true, allow_nil: true

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

    def name
      user ? user.name : read_attribute(:name)
    end

    def email
      user ? user.email : read_attribute(:email)
    end

    def priority_name
      SupportEngine::TicketPriority.name(priority)
    end

    private
    def notify_support_group
      support_type.notify!(self)
    end
  end
end
