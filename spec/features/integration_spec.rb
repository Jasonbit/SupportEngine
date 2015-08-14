require 'spec_helper'

RSpec.describe "Integration Test", type: :feature, js: true do
  before do
    SupportEngine.configure do |c|
      c.current_user_method = nil
    end

    visit "/"

    click_button I18n.t("support_engine.widget.toggle_btn")

    fill_in I18n.t("support_engine.widget.label"), with: "This is a question"

    click_button I18n.t("support_engine.widget.next")
  end

  it "validates" do
    click_button "Submit"

    expect(page).to have_css(".se-errors")
  end

  it "success" do
    fill_in I18n.t("support_engine.widget.name"), with: "Name"
    fill_in I18n.t("support_engine.widget.email"), with: "name@email.com"

    click_button "Submit"

    expect(page).to have_css(".se-success")
  end
end
