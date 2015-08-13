FactoryGirl.define do
  factory :ticket, class: SupportEngine::Ticket do
    title "Something wrong with the app"
    name "Mark Watney"
    email "mark@watney.com"
    state SupportEngine::TicketStates.open
  end
end
