module SupportEngine
  module TicketStates

    STATES = [
        [ :new,          'label-primary',  0],
        [ :open,         'label-warning',  1],
        [ :waiting,      'label-info',     2],
        [ :solved,       'label-success',  3],
        [ :not_fixable,  'label-default',  4],
        [ :unreachable,  'label-default',  5],
        [ :bug,          'label-default',  6]
      ]

    def states
      STATES
    end

    def state_keys
      STATES.map{|s| s[2] }
    end

    STATES.each do |name, _, value|
      define_method(name) do
        value
      end
    end

    extend self

    module Checker
      STATES.each do |name, _, value|
        define_method("#{name}?") do
          value == state
        end
      end
    end

  end
end
