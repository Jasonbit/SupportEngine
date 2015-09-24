module SupportEngine
  class Comment < ActiveRecord::Base
    attr_accessible :content, :ticket_id, :user_id

    belongs_to :ticket
    belongs_to :user, class_name: SupportEngine.config.user_class_name

    validates :content,   presence: true
    validates :ticket_id, presence: true
  end
end
