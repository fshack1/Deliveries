FactoryBot.define do
  factory :delivery do
    pickup_address { "Euston Rd., London N1C 4QP, United Kingdom" }
    delivery_address { "221B Baker St., London NW1 6XE, United Kingdom" }
    weight { 10 }
    distance { 20 }
    scheduled_time { (Time.zone.now + 1.day).strftime("%Y-%m-%dT%H:%M") }
    cost { 50 }
    driver_name { "Sherlock Holmes" }
  end
end
