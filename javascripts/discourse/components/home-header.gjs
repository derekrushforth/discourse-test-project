import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";

export default class HomeHeader extends Component {
  @service site;
  @service router;
  @service siteSettings;

  get isHomePage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  <template>
    {{#if this.isHomePage}}
      <div class="d-header-new">
        <div class="header-wrapper">
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
            <div class="header-wrapper_hero">
              <h2>Find solutions, share ideas<br />and discuss music</h2>
            </div>
          </div>
        </div>
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
