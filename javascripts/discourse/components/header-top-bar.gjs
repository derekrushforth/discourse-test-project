import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import icon from "discourse-common/helpers/d-icon";
import NavSidebar from "./nav-sidebar";
import UserMenu from "./user-menu";

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
                src={{this.siteSettings.logo}}
                alt="Spotify Community"
                class="navbar__logo"
              />
            {{/if}}
          </a>
        </h1>

        <ul class="navbar__items">
          <li>
            <a
              href="https://www.spotify.com/us/premium/?checkout=false"
              class="navbar__link"
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
              type="button"
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
