require_dependency "support_engine/application_controller"

module SupportEngine
  class TicketsController < ApplicationController
    def index
      @tickets = Ticket.limit(25).offset(25*params[:p].to_i)
    end

    def show
      @ticket = Ticket.find(params[:id])
    end
  end
end
