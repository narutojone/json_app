require 'rails_helper'

describe Ticket do
  let(:ticket) { FactoryGirl.create(:ticket) }

  context "validations" do
    it "creates json with valid fields" do
      expect(ticket).to be_persisted
    end

    it "requires original_json field" do
      json = Ticket.new(FactoryGirl.attributes_for(:ticket).except(:original_json))
      expect(json).not_to be_valid
      expect(json.errors).to be_present
      expect(json.errors[:original_json]).to be_present
    end
  end

  context "callbacks" do
    it "populates other fields correctly" do
      body = ticket.original_json

      expect(ticket.request_number).to eql(body["RequestNumber"])
      expect(ticket.sequence_number).to eql(body["SequenceNumber"].to_i)
      expect(ticket.request_type).to eql(body["RequestType"])
      expect(ticket.response_due_date_time.strftime("%Y/%m/%d %H:%M:%S")).to eql(body["DateTimes"]["ResponseDueDateTime"])
      expect(ticket.primary_service_area_code).to eql(body["ServiceArea"]["PrimaryServiceAreaCode"]["SACode"])
      expect(ticket.additional_service_area_codes).to eql(body["ServiceArea"]["AdditionalServiceAreaCodes"]["SACode"])
      expect(ticket.well_known_text).to eql(body["ExcavationInfo"]["DigsiteInfo"]["WellKnownText"])
    end

    it "creates excavator with correct fields" do
      body = ticket.original_json
      excavator = ticket.excavator
      excavator_json = ticket.original_json["Excavator"] || {}

      expect(excavator).to be_present
      expect(excavator).to be_persisted

      expect(excavator.company_name).to eql(excavator_json["CompanyName"])
      expect(excavator.street).to eql(excavator_json["Address"])
      expect(excavator.city).to eql(excavator_json["City"])
      expect(excavator.state).to eql(excavator_json["State"])
      expect(excavator.zip).to eql(excavator_json["Zip"])
      expect(excavator.crew_onsite.to_s).to eql(excavator_json["CrewOnsite"])
    end
  end
end
