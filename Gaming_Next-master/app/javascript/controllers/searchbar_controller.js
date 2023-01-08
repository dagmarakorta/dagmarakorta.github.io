import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {

  static targets = ["form", "input", "list", "searchdiv"]

  update() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`

    fetch(url, {headers: {"Accept": "text/plain"}})
      .then(response => response.text())
      .then((data) => {
        // console.log(data)
        this.listTarget.innerHTML = data
      })
  }

  close(e) {
    if (this.searchdivTarget.contains(e.target)){
      this.listTarget.style.display = ""
    } else{
      this.listTarget.style.display = "none"
      console.log(this.listTarget.classList)
    }
  }
}
