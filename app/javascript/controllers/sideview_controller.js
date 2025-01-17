import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="sideview"
export default class extends Controller {
  static targets = ["content", "url", "panel"];

  openView(event) {
    event.preventDefault();
    const url = this.urlTarget.href;

    fetch(url, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
      .then(response => {
        if (response.ok) {
          response.text().then(html => {
            this.contentTarget.innerHTML = html;
            this.panelTarget.classList.add("open");
            document.addEventListener("mousedown", this.handleOutsideClick.bind(this));
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
    document.removeEventListener("mousedown", this.handleOutsideClick.bind(this))
  }

  handleOutsideClick(event) {
    if (!this.contentTarget.contains(event.target)) {
      this.closeView();
    }
  }
}
