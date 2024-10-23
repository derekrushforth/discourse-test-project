import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";
import userDropdown from "discourse/components/header/user-dropdown";
import userMenuWrapper from "discourse/components/header/user-menu-wrapper";
import userNav from "discourse/components/user-nav";

export default class HomeHeader extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;

  constructor() {
    super(...arguments);
    console.log("Current user:", this.currentUser);
  }

  get isHomePage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }


  actions = {
    toggleNavSidebar() {
      const navSidebar = document.querySelector('.js-nav-sidebar');
      navSidebar.classList.toggle('is-active');
    },

    toggleDropdown(event) {
      console.log('TEST')
      // const dropdownMenu = event.target.closest('.custom-user-dropdown').querySelector('.custom-user-dropdown-menu');
      // dropdownMenu.classList.toggle('is-active');
    }
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
                <a href="https://www.spotify.com/us/premium/?checkout=false">Get
                  Premium</a>
              </li>

              {{#if this.currentUser}}
                {{userDropdown currentUser=this.currentUser}}
                {{!-- {{userMenuWrapper currentUser=this.currentUser}} --}}
                <li>
                  {{!-- <a href="/my/preferences">{{this.currentUser.username}}</a> --}}
                </li>
                
              {{else}}
                <li>
                  <a href="/login">Log In</a>
                </li>
              {{/if}}

              <li>
                <button
                  title="Navigation"
                  class="btn btn-flat btn-nav-toggle no-text btn-icon"
                  aria-expanded="false"
                  aria-controls="nav-sidebar"
                  onClick={{action "toggleNavSidebar"}}
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
            aria-expanded="false"
            aria-controls="nav-sidebar"
            onClick={{action "toggleNavSidebar"}}
          >
            {{icon "times"}}
          </button>

        </nav>
        <div class="nav-sidebar-overlay" onClick={{action "toggleNavSidebar"}}></div>

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
