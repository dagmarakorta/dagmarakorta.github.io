import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="share-modal"
export default class extends Controller {
  static targets = ["text", "tooltip"];

  connect() {
  }
  copy(event) {
    event.preventDefault();
    navigator.clipboard.writeText(this.textTarget.value);
    this.tooltipTarget.style.display = "inline";
    let tooltip = this.tooltipTarget;
    window.setTimeout( () => {
      tooltip.style.display = "none";
    }, 1000);
  }
}
