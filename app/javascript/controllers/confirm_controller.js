import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirm"
export default class extends Controller {
  confirm(event) {
    if (!confirm("Are you sure you want to proceed?")) {
      event.preventDefault();
    }
  }
}
