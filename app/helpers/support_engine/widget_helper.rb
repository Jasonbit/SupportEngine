module SupportEngine
  module WidgetHelper
    def support_engine_widget
      render partial: "support_engine/tickets/widget"
    end

    def support_engine_current_user
      current_user_method = SupportEngine.config.current_user_method
      current_user_method ? send(current_user_method) : nil
    end
  end
end
