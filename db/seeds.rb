# Mock delivery data
[
  {
    pickup_address: "123 Main Street, Springfield",
    delivery_address: "456 Elm Street, Shelbyville",
    weight: 10.5,
    distance: 15.2,
    scheduled_time: Time.zone.now + 1.day,
    cost: 42.50,
    driver_name: "John Doe"
  },
  {
    pickup_address: "123 Main Street, Springfield",
    delivery_address: "456 Elm Street, Shelbyville",
    weight: 12.0,
    distance: 15.0,
    scheduled_time: Time.zone.now + 1.day,
    cost: 45.00,
    driver_name: "Jane Smith"
  },
  {
    pickup_address: "789 Oak Avenue, Ogdenville",
    delivery_address: "101 Pine Lane, North Haverbrook",
    weight: 25.0,
    distance: 30.5,
    scheduled_time: Time.zone.now + 3.days,
    cost: 41.00,
    driver_name: nil
  }
].each do |delivery_data|
  Delivery.create!(
    pickup_address: delivery_data[:pickup_address],
    delivery_address: delivery_data[:delivery_address],
    weight: delivery_data[:weight],
    distance: delivery_data[:distance],
    scheduled_time: delivery_data[:scheduled_time],
    cost: delivery_data[:cost],
    driver_name: delivery_data[:driver_name]
  )
end
