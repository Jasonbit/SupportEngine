module SupportEngine
  class Engine < ::Rails::Engine
    isolate_namespace SupportEngine

    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false

      initializer 'support_engine.action_view' do |app|
        ActiveSupport.on_load :action_view do
          ::ActionView::Base.send :include, SupportEngine::WidgetHelper
        end
      end
    end
  end
end
