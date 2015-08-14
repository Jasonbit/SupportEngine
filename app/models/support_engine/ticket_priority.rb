module SupportEngine
  module TicketPriority

    PRIORITY = [
        [ :normal,  'label-default', 0],
        [ :high,    'label-warning', 1],
        [ :blocker, 'label-danger',  2],
        [ :feature, 'label-info',    3]
    ]
    def priorities
      PRIORITY
    end

    def priorities_keys
      PRIORITY.map{|s| s[2] }
    end

    PRIORITY.each do |name, _, value|
      define_method(name) do
        value
      end
    end

    def name(value)
      PRIORITY[value][0]
    end

    def label(value)
      PRIORITY[value][1]
    end

    extend self
  end
end

