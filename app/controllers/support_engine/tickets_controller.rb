require_dependency "support_engine/application_controller"

module SupportEngine
  class TicketsController < ApplicationController
    def index
      @tickets = Ticket.limit(25).offset(25*params[:p].to_i)
    end

    def show
      @ticket = Ticket.find(params[:id])
    end

    def update
      @ticket = Ticket.find(params[:id])

      respond_to do |fmt|
        if @ticket.update_attributes(params[:ticket])
          fmt.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        else
          fmt.html { render action: "show" }
        end
      end
    end
  end
end
