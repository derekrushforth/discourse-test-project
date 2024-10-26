import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import Breadcrumbs from "./breadcrumbs";
import HeaderSearch from "./header-search";
import HeaderTopBar from "./header-top-bar";
import HeaderCategories from "./header-categories";

export default class Header extends Component {
  @service site;
  @service router;
  @service siteSettings;
  @service currentUser;

  get isHomePage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  get isLoggedIn() {
    return !!this.currentUser;
  }

  <template>
    {{#if this.isLoggedIn}}
      {{bodyClass "logged-in"}}
    {{/if}}

    {{#if this.isHomePage}}
      <div class="header-wrapper">
        <HeaderTopBar />
        <div class="header-wrapper__hero">
          <h2>Find solutions, share ideas<br />and discuss music</h2>
          <div class="main-search main-search--home">
            <HeaderSearch />
          </div>
        </div>
        <HeaderCategories />
      </div>
    {{else}}
      <div class="header-wrapper header-wrapper--slim">
        <HeaderTopBar />
        <div class="main-search">
          <HeaderSearch />
        </div>
        <Breadcrumbs />
      </div>
    {{/if}}
  </template>
}
