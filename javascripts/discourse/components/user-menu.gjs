import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";
import Notifications from "discourse/components/header/user-dropdown/notifications";
import userMenuWrapper from "discourse/components/header/user-menu-wrapper";
import icon from "discourse-common/helpers/d-icon";

export default class UserMenu extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;
  @tracked showUserMenu = false;
  @tracked outsideRecentlyClicked = false;

  @action
  toggleUserMenu() {
    // Simple debounce to prevent multiple calls(from outside click) if user menu is already open
    if (this.outsideRecentlyClicked) {
      return;
    }

    this.showUserMenu = !this.showUserMenu;
  }

  @action
  userMenuOutsideClick() {
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
          type="button"
        >
          <Notifications @active={{this.showUserMenu}} />
          <span class="user_menu__username">{{this.currentUser.username}}</span>
          {{icon "caret-down"}}
        </button>

        {{#if this.showUserMenu}}
          {{userMenuWrapper toggleUserMenu=this.userMenuOutsideClick}}
        {{/if}}
      </li>
    {{else}}
      <li>
        <a href="/signup" class="navbar__link">Sign Up</a>
      </li>
      <li>
        <a href="/login" class="navbar__link">Log In</a>
      </li>
    {{/if}}
  </template>
}
