import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";
import { tracked } from "@glimmer/tracking";
import Notifications from "discourse/components/header/user-dropdown/notifications";
import UserMenu from "./user-menu";
import NavSidebar from "./nav-sidebar";
import HeaderSearch from "./header-search";
import HeaderTopBar from "./header-top-bar";

export default class HomeHeader extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;
  @tracked showNavSidebar = false;

  @action
  toggleNavSidebar() {
    const navSidebar = document.querySelector(".js-nav-sidebar");
    navSidebar.classList.toggle("is-active");
    this.showNavSidebar = !this.showNavSidebar;
  }

  <template>
    <div class="wrap">
      <div class="navbar">
        <h1>
          <a href="/">
            {{#if this.siteSettings.logo}}
              <img
                src="{{this.siteSettings.logo}}"
                alt="Spotify Community"
                class="navbar_logo"
              />
            {{/if}}
          </a>
        </h1>

        <ul class="navbar_items">
          <li>
            <a
              href="https://www.spotify.com/us/premium/?checkout=false"
              class="navbar_link"
            >Get Premium</a>
          </li>
          <UserMenu />
          <li>
            <button
              title="Navigation"
              class="btn btn-flat btn-nav-toggle no-text btn-icon"
              aria-expanded={{this.showNavSidebar}}
              aria-controls="nav-sidebar"
              onClick={{this.toggleNavSidebar}}
            >
              {{icon "bars"}}
            </button>
          </li>
        </ul>
      </div>
    </div>

    <NavSidebar
      @isOpen={{this.showNavSidebar}}
      @onClose={{this.toggleNavSidebar}}
    />
  </template>
}
