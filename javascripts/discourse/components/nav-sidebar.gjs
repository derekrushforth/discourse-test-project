import Component from "@glimmer/component";
import { action } from "@ember/object";
import icon from "discourse-common/helpers/d-icon";

export default class NavSidebar extends Component {
  @action
  closeNavSidebar() {
    this.args.onClose();
  }

  <template>
    <nav role="navigation" class="js-nav-sidebar nav-sidebar">
      <button
        title="Navigation"
        class="btn btn-flat btn-nav-toggle no-text btn-icon"
        aria-expanded={{@isOpen}}
        aria-controls="nav-sidebar"
        onClick={{this.closeNavSidebar}}
      >
        {{icon "times"}}
      </button>
    </nav>

    <div class="nav-sidebar-overlay" onClick={{this.closeNavSidebar}}></div>
  </template>
}
