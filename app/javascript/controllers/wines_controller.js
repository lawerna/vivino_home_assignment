import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  refresh() {
    document.getElementById('query_submit').click()
  }
}
