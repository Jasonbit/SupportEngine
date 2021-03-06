require 'spec_helper'

module SupportEngine
  describe Ticket do
    context "Validations" do
      it "validates name and email only if there's no user" do
        ticket = Ticket.new
        expect(ticket).to be_invalid
        expect(ticket.errors[:name]).to_not be_blank

        ticket.user = User.new
        expect(ticket).to be_invalid
        expect(ticket.errors[:name]).to be_blank
      end

      it "validates state inclusion" do
        ticket = Ticket.new
        ticket.state = 8
        ticket.valid?
        expect(ticket.errors[:state]).to_not be_blank
        ticket.state = TicketStates.open
        ticket.valid?
        expect(ticket.errors[:state]).to be_blank
      end
    end

    context "State" do
      subject { Ticket.new }
      it "knows if its on a state" do
        subject.state = TicketStates.open
        expect(subject).to be_open
        expect(subject).to_not be_solved
      end
    end

    context "Getters" do
      let(:user) { User.new(name: "User", email: "user@email.com") }
      it "#name" do
        t = Ticket.new
        expect(t.name).to be_nil
        t.name = "Gabriel"
        expect(t.name).to eq("Gabriel")
        t.user = user
        expect(t.name).to eq("User")
      end

      it "#email" do
        t = Ticket.new
        expect(t.email).to be_nil
        t.email = "gabriel@email.com"
        expect(t.email).to eq("gabriel@email.com")
        t.user = user
        expect(t.email).to eq("user@email.com")
      end
    end
  end
end
