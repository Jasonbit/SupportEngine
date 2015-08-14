module SupportEngine
  class SupportType < ActiveRecord::Base
    attr_accessible :name, :email

    has_many :tickets, inverse_of: :support_type
  end
end
