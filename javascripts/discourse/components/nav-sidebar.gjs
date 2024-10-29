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
    const ul = li.querySelector("ul.nav-sidebar__sublist");
    const allSublists = document.querySelectorAll("ul.nav-sidebar__sublist");

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
          <ul class="nav-sidebar__sublist" style="display:none">
            <li><a href="/categories">Announcements</a></li>
            <li><a href="/categories">Ongoing Issues</a></li>
            <li><a href="/categories">Accounts</a></li>
            <li><a href="/categories">Subscriptions</a></li>
            <li><a href="/categories">Premium Family</a></li>
            <li><a href="/categories">Premium Student</a></li>
            <li><a href="/categories">Your Library</a></li>
            <li><a href="/categories">iOS (iPhone, iPad)</a></li>
            <li><a href="/categories">Android</a></li>
            <li><a href="/categories">Desktop (Windows)</a></li>
            <li><a href="/categories">Desktop (Mac)</a></li>
            <li><a href="/categories">Desktop (Linux)</a></li>
            <li><a href="/categories">Content Questions</a></li>
            <li><a href="/categories">Car Thing</a></li>
            <li><a href="/categories">Other (Podcasts, Partners, etc.)</a></li>
            <li><a href="/categories">Spotify for Developers</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Chat</span></h3>
          <ul class="nav-sidebar__sublist" style="display:none">
            <li><a href="/categories">Music Exchange</a></li>
            <li><a href="/categories">Music Discussion</a></li>
            <li><a href="/categories">Discovery &amp; Promo</a></li>
            <li><a href="/categories">Social &amp; Random</a></li>
            <li><a href="/categories">Podcast Discussion</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Spotify Stars</span></h3>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Ideas</span></h3>
          <ul class="nav-sidebar__sublist" style="display:none">
            <li><a href="/categories">Implemented Ideas</a></li>
            <li><a href="/categories">Live Ideas</a></li>
            <li><a href="/categories">Closed Ideas</a></li>
          </ul>
        </li>
        <li data-url="/categories">
          <h3 onClick={{this.handleTitleClick}}><span>Vault</span></h3>
          <ul class="nav-sidebar__sublist" style="display:none">
            <li><a href="/categories">The Blog Vault</a></li>
            <li><a href="/categories">App &amp; Features</a></li>
          </ul>
        </li>
      </ul>
    </nav>

    <div class="nav-sidebar-overlay" onClick={{this.closeNavSidebar}}></div>
  </template>
}
