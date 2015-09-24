require_dependency "support_engine/application_controller"

module SupportEngine
  class CommentsController < ApplicationController
    def create
      comment = Comment.new(params[:comment])

      respond_to do |fmt|
        if comment.save
          fmt.html { redirect_to comment.ticket, notice: "Comment created successfully" }
        else
          fmt.html { redirect_to comment.ticket, notice: "Comment created successfully" }
        end
      end
    end
  end
end
