import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { action } from "@ember/object";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";
import HeaderSearch from "./header-search";
import HeaderTopBar from "./header-top-bar";
import HomeCategories from "./home-categories";

export default class HomeHeader extends Component {
  @service site;
  @service router;
  @service siteSettings;

  get isHomePage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

  <template>
    {{#if this.isHomePage}}
      <div class="header-wrapper">
        <HeaderTopBar />
        <div class="header-wrapper_hero">
          <h2>Find solutions, share ideas<br />and discuss music</h2>
          <div class="main-search main-search--home">
            <HeaderSearch />
          </div>
        </div>
        <HomeCategories />
      </div>
    {{else}}
      <div class="header-wrapper header-wrapper--slim">
        <HeaderTopBar />
        <HeaderSearch />
      </div>
    {{/if}}
  </template>
}
