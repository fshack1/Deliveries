# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@material/textfield", to: "@material--textfield.js" # @14.0.0
pin "@material/base/component", to: "@material--base--component.js" # @14.0.0
pin "@material/base/foundation", to: "@material--base--foundation.js" # @14.0.0
pin "@material/dom/events", to: "@material--dom--events.js" # @14.0.0
pin "@material/dom/ponyfill", to: "@material--dom--ponyfill.js" # @14.0.0
pin "@material/floating-label/component", to: "@material--floating-label--component.js" # @14.0.0
pin "@material/floating-label/foundation", to: "@material--floating-label--foundation.js" # @14.0.0
pin "@material/line-ripple/component", to: "@material--line-ripple--component.js" # @14.0.0
pin "@material/notched-outline/component", to: "@material--notched-outline--component.js" # @14.0.0
pin "@material/ripple/component", to: "@material--ripple--component.js" # @14.0.0
pin "@material/ripple/foundation", to: "@material--ripple--foundation.js" # @14.0.0
pin "@hotwired/turbo-rails", to: "@hotwired--turbo-rails.js" # @8.0.12
pin "@hotwired/turbo", to: "@hotwired--turbo.js" # @8.0.12
pin "@rails/actioncable/src", to: "@rails--actioncable--src.js" # @7.2.201
