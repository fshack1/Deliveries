# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def format_time(datetime)
    return "" unless datetime

    datetime.strftime("%H:%M %d/%m/%Y")
  end
end
