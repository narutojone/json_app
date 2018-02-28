class Ticket < ApplicationRecord
  has_one :excavator

  validates_presence_of :original_json

  before_create :extract_fields_from_original_json
  after_commit :auto_create_excavator, on: [:create]

  def well_known_shape
    if self.well_known_text
      shape = self.well_known_text.split("((").first.strip
      str = self.well_known_text.split("((").last.sub("))", "")
      point_str_arr = str.split(/\s*,\s*/)

      points = point_str_arr.collect{|point_str|
        numbers = point_str.split(/\s+/)
        {
          lat: numbers[1].to_f,
          lng: numbers[0].to_f
        }
      }

      {
        shape: shape,
        points: points
      }
    end
  end

  private

  def extract_fields_from_original_json
    self.request_number = self.original_json["RequestNumber"]
    self.sequence_number = self.original_json["SequenceNumber"]
    self.request_type = self.original_json["RequestType"]
    self.response_due_date_time = self.original_json["DateTimes"]
                                      .try(:[], "ResponseDueDateTime")
    self.primary_service_area_code = self.original_json["ServiceArea"]
                                         .try(:[], "PrimaryServiceAreaCode")
                                         .try(:[], "SACode")
    self.additional_service_area_codes = self.original_json["ServiceArea"]
                                             .try(:[], "AdditionalServiceAreaCodes")
                                             .try(:[], "SACode")
    self.well_known_text = self.original_json["ExcavationInfo"]
                               .try(:[], "DigsiteInfo")
                               .try(:[], "WellKnownText")
  end

  def auto_create_excavator
    excavator_attrs = {}
    excavator_json = self.original_json["Excavator"] || {}
    excavator_attrs[:company_name] = excavator_json["CompanyName"]
    excavator_attrs[:street] = excavator_json["Address"]
    excavator_attrs[:city] = excavator_json["City"]
    excavator_attrs[:state] = excavator_json["State"]
    excavator_attrs[:zip] = excavator_json["Zip"]
    excavator_attrs[:crew_onsite] = excavator_json["CrewOnsite"]

    self.create_excavator!(excavator_attrs)
  end
end
