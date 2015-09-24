require 'pry'
module SupportEngine
  module Api
    module V1
      class TicketsController < ApiController
        before_filter :validate_captcha, only: :create
        respond_to :json

        def create

          ticket = Ticket.new(params[:ticket])
          ticket.state = TicketStates.open
          ticket.priority = TicketPriority.normal

          if ticket.save
            render json: { ticket: ticket, message: t("support_engine.widget.message") },
                   status: :created, location: api_v1_ticket_url(ticket)
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

        def validate_captcha
          if params[:confirmation].present?
            render json: { captcha: "Error" }, status: :unprocessable_entity
            return
          end
        end
      end
    end
  end
end
