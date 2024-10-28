import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import { inject as service } from "@ember/service";

export default class Stats extends Component {
  // Static mapping to topic ids
  // TODO: This should likely be configured from the admin area
  static CATEGORIES = {
    ideas: { slug: "general", id: 4 },
    questions: { slug: "site-feedback", id: 2 },
  };
  @service store;
  @service siteSettings;

  // TODO: Consider caching values
  @tracked lastWeek;
  @tracked ideaCount = 0;
  @tracked questionCount = 0;
  @tracked conversationCount = 0;

  constructor() {
    super(...arguments);
    this.lastWeek = this.getLastWeekDate();
    this.initializeStats();
  }
  get statsIconUrl() {
    return settings.theme_uploads["stats-icon"];
  }

  get hasStats() {
    return (
      this.conversationCount > 0 && this.questionCount > 0 && this.ideaCount > 0
    );
  }

  getLastWeekDate() {
    const today = new Date();
    return today.setDate(today.getDate() - 7);
  }

  async initializeStats() {
    await Promise.all([
      this.loadIdeas(),
      this.loadQuestions(),
      this.loadConversations(),
    ]);
  }

  async fetchData(url) {
    const response = await fetch(url);
    const data = await response.json();

    if (!response.ok) {
      throw new Error(`Failed to fetch data from ${url}`);
    }

    return data;
  }

  // Filter items within the last week
  filterByDate(items, dateField = "created_at") {
    return items.filter((item) => new Date(item[dateField]) >= this.lastWeek);
  }

  // Load new idea topics from the last week
  @action
  async loadIdeas() {
    try {
      const { slug, id } = Stats.CATEGORIES.ideas;
      const data = await this.fetchData(`/c/${slug}/${id}.json`);

      this.ideaCount = this.filterByDate(data.topic_list.topics || []).length;
    } catch (error) {
      throw new Error("Error loading ideas:", error);
    }
  }

  // Load new questions with activity from the last week
  @action
  async loadQuestions() {
    try {
      const { slug, id } = Stats.CATEGORIES.questions;
      const data = await this.fetchData(`/c/${slug}/${id}.json`);

      this.questionCount = this.filterByDate(
        data.topic_list.topics || [],
        "last_posted_at"
      ).length;
    } catch (error) {
      throw new Error("Error loading questions", error);
    }
  }

  // Load total posts from the last week
  @action
  async loadConversations() {
    try {
      const data = await this.fetchData("/posts.json");

      this.conversationCount = this.filterByDate(
        data.latest_posts || []
      ).length;
    } catch (error) {
      throw new Error("Error loading conversations", error);
    }
  }

  <template>
    {{#if this.hasStats}}
      <div class="stats stats--loaded">
        <div class="stats__container">
          <img
            src={{this.statsIconUrl}}
            alt="Statistics image"
            class="stats__icon"
          />
          <p>
            In the last week you chatty lot had
            <span>{{this.conversationCount}} conversations</span>, helped each
            other answer
            <span>{{this.questionCount}} questions</span>
            and came up with
            <span>{{this.ideaCount}} new ideas</span>. Good work!
          </p>
        </div>
      </div>
    {{/if}}
  </template>
}
