import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs"

// Connects to data-controller="wishlist"
export default class extends Controller {
  static targets = ["number"]

  connect() {
    this.Sortable = Sortable.create(this.element, {
      onEnd: this.persist.bind(this)
    })
  }

  persist(event) {
    const list = document.querySelector("#wishlist")
    const listItems = list.querySelectorAll("li")
    const listIds = Array.from(listItems).map(item => item.dataset.id)
    const url = `/wishlists/order`
    const data = { list_items_attributes: listIds }
    Rails.ajax({
      type: "patch",
      url: url,
      data: new URLSearchParams(data).toString()
    })
    // refresh page on drop
    location.reload()
  }
}
