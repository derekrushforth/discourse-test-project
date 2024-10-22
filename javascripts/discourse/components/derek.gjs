import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import bodyClass from "discourse/helpers/body-class";
import { defaultHomepage } from "discourse/lib/utilities";
import icon from "discourse-common/helpers/d-icon";
import formatDate from "discourse/helpers/format-date";

export default class Derek extends Component {
  @service site;
  @service router;

  get displayCustomHomepage() {
    return this.router.currentRouteName === `discovery.${defaultHomepage()}`;
  }

    get currentDate() {
    return new Date().toLocaleString();
  }

  <template>
    {{#if this.displayCustomHomepage}}
      hiiiiii this worked
      <p>Current date: {{this.currentDate}}</p>


    {{/if}}
  </template>
}
