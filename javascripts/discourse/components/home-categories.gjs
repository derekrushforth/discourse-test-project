import Component from "@glimmer/component";
import icon from "discourse-common/helpers/d-icon";

export default class HomeHeader extends Component {
  <template>
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
  </template>
}