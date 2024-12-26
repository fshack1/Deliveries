# frozen_string_literal: true

module DeliveriesHelper
  def delivery_filters
    tag.div(class: "table-filter-container") do
      driver_filter + pickup_filter
    end
  end

  private def driver_filter
    form_with(url: deliveries_path, method: :get, local: true) do |form|
      form.select(
        :driver_name,
        options_for_select(Delivery.distinct.pluck(:driver_name).reject(&:blank?).uniq, params[:driver_name]),
        { prompt: "Filter by driver" },
        { onchange: "this.form.submit()", class: "filter-button"}
      )
    end
  end

  private def pickup_filter
    form_with(url: deliveries_path, method: :get, local: true) do |form|
      form.select(
        :pickup_address,
        options_for_select(Delivery.distinct.pluck(:pickup_address), params[:pickup_address]),
        { prompt: "Filter by pickup" },
        { onChange: "this.form.submit()", class: "filter-button"}
      )
    end
  end
end
