class Api::V1::TicketsController < Api::V1::BaseController
  def create
    json = json_param

    if json.present?
      Ticket.create!(original_json: json)
    else
      head 400
    end
  end

  private

  def json_param
    json_str = params[:json]

    if json_str.present?
      begin
        json = JSON.parse(json_str)
      rescue JSON::ParserError => e
      end
    end
  end
end
