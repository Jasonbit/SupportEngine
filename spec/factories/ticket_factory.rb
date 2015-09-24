FactoryGirl.define do
  factory :ticket, class: SupportEngine::Ticket do
    title "Something wrong with the app"
    name "Mark Watney"
    email "mark@watney.com"
    state SupportEngine::TicketStates.open
    priority SupportEngine::TicketPriority.normal
    association :support_type
  end
end
