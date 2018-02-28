module ApplicationHelper
  def format_date(date)
    date ? date.strftime("%m/%d/%Y") : date
  end
end
