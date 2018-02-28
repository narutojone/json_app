class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string :request_number, limit: 20
      t.integer :sequence_number
      t.string :request_type, limit: 20
      t.datetime :response_due_date_time
      t.string :primary_service_area_code, limit: 10
      t.json :additional_service_area_codes
      t.text :well_known_text
      t.json :original_json

      t.timestamps
    end
  end
end
