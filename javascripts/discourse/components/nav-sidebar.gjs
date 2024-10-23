import Component from "@glimmer/component";
import { action } from "@ember/object";
import icon from "discourse-common/helpers/d-icon";

export default class NavSidebar extends Component {
  @action
  closeNavSidebar() {
    this.args.onClose();
  }

  // Preserving behavior of existing Spotify sidebar
  // Clicking an h3 with no sublist => navigate to url
  // Clicking an h3 with a sublist => display sublist
  // Clicking an h3 with a visible sublist => navigate to url
  @action
  handleClick(event) {
    const h3 = event.target.closest("h3");

    if (h3) {
      const li = h3.closest("li");
      if (li) {
        const ul = h3.nextElementSibling;

        if (ul && ul.tagName === "UL") {
          if (ul.style.display === "none") {
            ul.style.display = "block";
          } else {
            const url = li.dataset.url;

            if (url) {
              window.location.href = url;
            }
          }
        } else {
          const url = li.dataset.url;

          if (url) {
            window.location.href = url;
          }
        }
      }
    }
  }

  <template>
    <nav role="navigation" class="js-nav-sidebar nav-sidebar">
      <button
        title="Navigation"
        class="btn btn-flat btn-nav-toggle no-text btn-icon"
        aria-expanded={{@isOpen}}
        aria-controls="nav-sidebar"
        onClick={{this.closeNavSidebar}}
      >
        {{icon "times"}}
      </button>

      <ul onclick={{this.handleClick}}>
        <li data-url="/categories">
          <h3><span>Community Guidelines</span></h3>
        </li>
        <li data-url="/categories">
          <h3><span>Community Blog</span></h3>
        </li>
        <li data-url="/categories">
          <h3><span>FAQs</span></h3>
        </li>
        <li data-url="/categories">
          <h3><span>Help</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3><span>Chat</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3><span>Spotify Stars</span></h3>
        </li>
        <li data-url="/categories">
          <h3><span>Ideas</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3><span>Vault</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
      </ul>

    </nav>

    <div class="nav-sidebar-overlay" onClick={{this.closeNavSidebar}}></div>
  </template>
}
