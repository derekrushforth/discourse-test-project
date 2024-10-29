/* eslint-disable ember/no-empty-glimmer-component-classes */
import Component from "@glimmer/component";
import icon from "discourse-common/helpers/d-icon";

export default class HeaderCategories extends Component {
  <template>
    <nav class="home-categories">
      <ul>
        <li>
          <a href="/categories">
            <div class="home-categories__icon">
              {{icon "question"}}
            </div>
            <div class="home-categories__content">
              <h3>Help</h3>
              <p>Need some assistance?</p>
            </div>
          </a>
        </li>
        <li>
          <a href="/categories">
            <div class="home-categories__icon">
              {{icon "comment"}}
            </div>
            <div class="home-categories__content">
              <h3>Chat</h3>
              <p>Discuss music and podcasts</p>
            </div>
          </a>
        </li>
        <li>
          <a href="/categories">
            <div class="home-categories__icon">
              {{icon "idea"}}
            </div>
            <div class="home-categories__content">
              <h3>Ideas</h3>
              <p>Share and vote for ideas</p>
            </div>
          </a>
        </li>
      </ul>
    </nav>
  </template>
}
