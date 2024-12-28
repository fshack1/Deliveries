import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  connect() {
    this.element.querySelectorAll('.mdc-text-field').forEach(element => {
      new mdc.textField.MDCTextField(element);
    });
  }
}
