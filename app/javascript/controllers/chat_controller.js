import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["inputfield"]

  closeChat() {
    const chatWindow = document.getElementById("chat-window");
    chatWindow.outerHTML = `
      <turbo-frame id="chat-window">
      </turbo-frame>
    `;
  
    const chatButtonFrame = `
      <turbo-frame id="chat-button-frame">
        <div style="text-align: right; padding-top: 10px">
          <form action="/chats" method="get" data-turbo="true">
            <button type="submit" class="mdc-button--outlined" data-turbo-stream="true">Chat with AI</button>
          </form>
        </div>
      </turbo-frame>
    `;
    document.getElementById("chat-window").insertAdjacentHTML("beforebegin", chatButtonFrame);
  }

  clearInput(event) {
    if (event.detail.success) {
      this.inputfieldTarget.value = ""
    }
  }
}
