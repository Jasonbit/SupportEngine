require 'pry'
module SupportEngine
  module Api
    module V1
      class TicketsController < ApiController
        respond_to :json

        def create
          ticket = Ticket.new(params[:ticket])
          ticket.state = TicketStates.open
          if ticket.save
            render json: ticket, status: :created,
                   location: api_v1_ticket_url(ticket)
          else
            render json: ticket.errors, status: :unprocessable_entity
          end
        end

        def index
          if params[:q].present?
            query = params[:q].split(" ").join("%")
            tickets = Ticket.where("title LIKE ?", "%#{query}%")
          else
            tickets = Ticket
          end

          ticket = ticket.offset(10*params[:p].to_i) if params[:p].to_i > 0

          render json: { tickets: tickets.limit(10) }
        end
      end
    end
  end
end
