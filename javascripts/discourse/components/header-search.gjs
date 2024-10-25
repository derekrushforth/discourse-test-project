import Component from "@glimmer/component";
import { action } from "@ember/object";
import SearchMenu from "discourse/components/search-menu";
import icon from "discourse-common/helpers/d-icon";

export default class HeaderSearch extends Component {
  <template>
    <div class="search-wrapper">
      <SearchMenu />
      {{icon "search"}}
    </div>
  </template>
}
