import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sideview"
export default class extends Controller {
  static targets = ["content", "panel"];

  connect() {
    document.addEventListener("mousedown", this.handleOutsideClick.bind(this));
  }

  disconnect() {
    document.removeEventListener("mousedown", this.handleOutsideClick.bind(this))
  }

  openView(event) {
    event.preventDefault();
    const url = event.currentTarget.querySelector("a").href;
  
    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
      .then(response => {
        if (response.ok) {
          console.log(response)
          response.text().then(html => {
            console.log(html)
            this.contentTarget.innerHTML = html;
            this.panelTarget.classList.add("open");
          });
        } else {
          console.error("Failed to fetch Turbo Stream content:", response);
        }
      })
      .catch(error => {
        console.error("Error fetching Turbo Stream content:", error);
      });
  }

  closeView() {
    this.panelTarget.classList.remove("open");
    this.contentTarget.innerHTML = "";
  }

  handleOutsideClick(event) {
    if (!this.contentTarget.contains(event.target)) {
      this.closeView();
    }
  }
}
