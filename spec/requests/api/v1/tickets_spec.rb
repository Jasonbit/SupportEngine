require 'spec_helper'

module SupportEngine
  describe "Tickets API", type: :request do

    context "without user" do
      it "doesn't create with name and email" do
        post '/help/api/v1/tickets', { ticket: { title: "Something wrong" }  }

        expect(response).to_not be_success

        json = JSON.parse(response.body)
        expect(json['name']).to be_present
      end

      it 'creates a ticket with name and email' do
        post '/help/api/v1/tickets', { ticket: { title: "Something wrong",
                                                name: "Gabriel", email: "gabriel@example.com"} }

        expect(response).to be_success

        json = JSON.parse(response.body)
        expect(json['title']).to match(/wrong/)
      end
    end
  end
end
