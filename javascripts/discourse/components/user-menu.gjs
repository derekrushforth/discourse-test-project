import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";
import icon from "discourse-common/helpers/d-icon";
import userMenuWrapper from "discourse/components/header/user-menu-wrapper";
import { tracked } from "@glimmer/tracking";
import Notifications from "discourse/components/header/user-dropdown/notifications";

export default class UserMenu extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;
  @tracked showUserMenu = false;
  @tracked outsideRecentlyClicked = false;

  @action
  toggleUserMenu(event) {
    // Simple debounce to prevent multiple calls(from outside click) if user menu is already open
    if (this.outsideRecentlyClicked) {
      console.log("outside recently clicked");
      return;
    }

    this.showUserMenu = !this.showUserMenu;
  }

  @action
  userMenuOutsideClick(event) {
    this.showUserMenu = false;
    this.outsideRecentlyClicked = true;

    setTimeout(() => {
      this.outsideRecentlyClicked = false;
    }, 200);
  }

  <template>
    {{#if this.currentUser}}
      <li class="user-menu">
        <button
          id="toggle-current-user"
          class="js-toggle-current-user icon btn-flat
            {{if this.showUserMenu 'is-active'}}"
          aria-haspopup="true"
          aria-expanded={{this.showUserMenu}}
          onClick={{this.toggleUserMenu}}
        >
          <Notifications @active={{this.showUserMenu}} />
          <span class="user-menu_username">{{this.currentUser.username}}</span>
          {{icon "caret-down"}}
        </button>

        {{#if this.showUserMenu}}
          {{userMenuWrapper toggleUserMenu=this.userMenuOutsideClick}}
        {{/if}}
      </li>
    {{else}}
      <li>
        <a href="/login" class="navbar_link">Log In</a>
      </li>
    {{/if}}
  </template>
}
