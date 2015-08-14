require 'spec_helper'

module SupportEngine
  describe "Tickets API", type: :request do

    context "#create" do
      context "without user" do
        it "doesn't create with name and email" do
          post '/help/api/v1/tickets', { ticket: { title: "Something wrong" }  }

          expect(response).to_not be_success

          json = JSON.parse(response.body)
          expect(json['name']).to be_present
        end

        it 'creates a ticket with name and email' do
          support_type = FactoryGirl.create(:support_type)
          post '/help/api/v1/tickets', { ticket: { title: "Something wrong",
                                                   support_type_id: support_type.id,
                                                   name: "Gabriel", email: "gabriel@example.com"} }

          expect(response).to be_success

          json = JSON.parse(response.body)
          expect(json['ticket']['title']).to match(/wrong/)
        end
      end
    end

    context "#index" do
      before { FactoryGirl.create_list(:ticket, 11) }

      it "returns the first ten" do
        get '/help/api/v1/tickets'

        expect(response).to be_success            # test for the 200 status-code
        json = JSON.parse(response.body)
        expect(json['tickets'].length).to eq(10)
      end

      it "returns only if match query" do
        FactoryGirl.create(:ticket, title: "I have a great idea")
        get '/help/api/v1/tickets', q: "have idea"

        expect(response).to be_success
        json = JSON.parse(response.body)
        expect(json['tickets'].length).to eq(1)
      end
    end
  end
end

