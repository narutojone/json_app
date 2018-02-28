require 'rails_helper'

describe Api::V1::TicketsController do
  let(:json_str) {
    FactoryGirl.attributes_for(:ticket)[:original_json]
  }

  describe "POST create" do
    context "json parameter is present" do
      it "records json" do
        json_param = json_str
        expect {
          post :create, params: {json: json_param.to_json}
        }.to change{Ticket.count}.by(1)

        record = Ticket.order(created_at: :desc).first
        expect(JsonDiff.diff(record.original_json.deep_symbolize_keys, json_param)).to be_blank
      end
    end

    context "json parameter is missing" do
      it "returns bad request error" do
        post :create
        expect(response.status).to eql(400)
      end
    end
  end
end
