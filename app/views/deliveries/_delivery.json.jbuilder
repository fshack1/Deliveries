json.extract! delivery, :id, :pickup_address, :delivery_address, :weight, :distance, :scheduled_time, :cost, :driver_name, :created_at, :updated_at
json.url delivery_url(delivery, format: :json)
