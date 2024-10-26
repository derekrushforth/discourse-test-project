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
  handleTitleClick(event) {
    const li = event.target.closest("li");
    const ul = li.querySelector("ul.nav-sidebar_sublist");
    const allSublists = document.querySelectorAll("ul.nav-sidebar_sublist");

    // Check for sublist
    if (ul) {
      // If sublist is hidden
      if (ul.style.display === "none") {
        // Hide all other sublists
        allSublists.forEach((sublist) => {
          sublist.style.display = "none";
        });

        // Show closest sublist
        ul.style.display = "block";
      } else {
        this.navigateToUrl(li);
      }
    } else {
      this.navigateToUrl(li);
    }
  }

  @action
  navigateToUrl(element) {
    const url = element.dataset.url;

    if (url) {
      window.location.href = url;
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
        type="button"
      >
        {{icon "times"}}
      </button>

      <ul>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Community Guidelines</span></h3>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Community Blog</span></h3>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>FAQs</span></h3>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Help</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Chat</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Spotify Stars</span></h3>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Ideas</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Vault</span></h3>
          <ul class="nav-sidebar_sublist" style="display:none">
            <li><a href="#">TODO: List subtopics</a></li>
          </ul>
        </li>
      </ul>
    </nav>

    <div class="nav-sidebar-overlay" onClick={{this.closeNavSidebar}}></div>
  </template>
}
