import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";
// import userDropdown from "discourse/components/header/user-dropdown";
import userMenuWrapper from "discourse/components/header/user-menu-wrapper";
// import userNav from "discourse/components/user-nav";
import { tracked } from "@glimmer/tracking";
import Notifications from "discourse/components/header/user-dropdown/notifications";

export default class HomeHeader extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;
  @tracked showUserMenu = false;
  @tracked outsideRecentlyClicked = false;
  @tracked showNavSidebar = false;

  constructor() {
    super(...arguments);
    console.log("Current user:", this.currentUser);
  }

  get isHomePage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  @action
  toggleNavSidebar() {
    const navSidebar = document.querySelector(".js-nav-sidebar");
    navSidebar.classList.toggle("is-active");
    this.showNavSidebar = !this.showNavSidebar;
  }

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
    {{#if this.isHomePage}}
      <div class="header-wrapper">
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
                    <span
                      class="user-menu_username"
                    >{{this.currentUser.username}}</span>
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

        {{! Navigation overlay }}

        <nav role="navigation" class="js-nav-sidebar nav-sidebar">
          <button
            title="Navigation"
            class="btn btn-flat btn-nav-toggle no-text btn-icon"
            aria-expanded={{this.showNavSidebar}}
            aria-controls="nav-sidebar"
            onClick={{this.toggleNavSidebar}}
          >
            {{icon "times"}}
          </button>

        </nav>
        <div
          class="nav-sidebar-overlay"
          onClick={{this.toggleNavSidebar}}
        ></div>

        <div class="header-wrapper_hero">
          <h2>Find solutions, share ideas<br />and discuss music</h2>
          <div class="main-search main-search--home">
            <input type="text" placeholder="Search" />
          </div>
        </div>

        <nav class="home-categories">
          <ul>
            <li>
              <a href="/categories">
                <div class="home-categories_icon">
                  {{icon "question-circle"}}
                </div>
                <div class="home-categories_content">
                  <h3>Help</h3>
                  <p>Need some assistance?</p>
                </div>
              </a>
            </li>
            <li>
              <a href="/categories">
                <div class="home-categories_icon">
                  {{icon "question-circle"}}
                </div>
                <div class="home-categories_content">
                  <h3>Chat</h3>
                  <p>Discuss music and podcasts</p>
                </div>
              </a>
            </li>
            <li>
              <a href="/categories">
                <div class="home-categories_icon">
                  {{icon "question-circle"}}
                </div>
                <div class="home-categories_content">
                  <h3>Ideas</h3>
                  <p>Share and vote for ideas</p>
                </div>
              </a>
            </li>
          </ul>
        </nav>
      </div>
    {{else}}
      <div class="d-header-new">
        <div class="header-wrapper header-wrapper--slim">
          <div class="wrap">
            <h1>
              <a href="/">
                {{#if this.siteSettings.logo}}
                  <img
                    src="{{this.siteSettings.logo}}"
                    alt="Spotify Community"
                    class="navbar-logo"
                  />
                {{/if}}
              </a>
            </h1>

            <button
              title="Sidebar"
              class="btn btn-flat btn-sidebar-toggle no-text btn-icon"
              aria-expanded="true"
              aria-controls="d-sidebar"
            >
              <svg
                class="fa d-icon d-icon-bars svg-icon svg-string"
                xmlns="http://www.w3.org/2000/svg"
              ><use href="#bars"></use></svg>
            </button>
          </div>
        </div>
      </div>
    {{/if}}
  </template>
}
