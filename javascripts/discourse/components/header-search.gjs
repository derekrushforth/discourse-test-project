import Component from "@glimmer/component";
import { action } from "@ember/object";
import icon from "discourse-common/helpers/d-icon";
import SearchMenu from "discourse/components/search-menu";

export default class HeaderSearch extends Component {
  <template>
    <div class="search-wrapper">
      <SearchMenu />
      {{icon "search"}}
    </div>
  </template>
}
