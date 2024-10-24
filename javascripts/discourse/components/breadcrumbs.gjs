/*
 * Component extended from https://github.com/denvergeeks/discourse-breadcrumb-links
 */
import Component from "@glimmer/component";
import { inject as service } from "@ember/service";
import { or } from "truth-helpers";
import bodyClass from "discourse/helpers/body-class";
import Category from "discourse/models/category";
import icon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";
import { getOwner } from "@ember/application";

export default class Breadcrumbs extends Component {
  @service router;

  get currentPage() {
    const route = this.router.currentRouteName;

    switch (true) {
      case route === "discovery.categories":
        return i18n("js.category.all");
      case route.includes("userPrivateMessages"):
        return i18n("js.groups.messages");
      case route.startsWith("admin"):
        return i18n("js.admin_title");
      case route.startsWith("chat"):
        return i18n("js.chat.heading");
      case route === "userNotifications.responses" ||
        route === "userNotifications.mentions":
        return i18n("js.groups.mentions");
      case route === "userActivity.bookmarks":
        return i18n("js.user.bookmarks");
      case this.router?.currentRoute?.parent?.name === "docs":
        return i18n("js.docs.title");
      case this.router?.currentRoute?.parent?.name === "preferences":
        return i18n("js.user.preferences.title");
      case route === "discourse-post-event-upcoming-events.index":
        return i18n("js.discourse_post_event.upcoming_events.title");
      case route === "tags.index":
        return i18n("js.tagging.all_tags");
      case route.includes("Category") || route.includes("category"):
        return this.categoryName;
      case route.includes("discovery.top"):
        return i18n("js.filters.top.title");
      case route === "user.summary":
        return i18n("js.user.summary.title");
      case route.includes("userActivity"):
        return i18n("js.user.activity_stream");
      case route === "userNotifications.index":
        return i18n("js.user.notifications");
      case route === "userInvited.show":
        return i18n("js.user.invited.title");
      case route === "user.badges":
        return i18n("js.badges.title");
      case route.includes("topic.fromParams"):
        const topicController = getOwner(this).lookup("controller:topic");
        if (topicController && topicController.model) {
          return topicController.model.title;
        }
      default:
        return null;
    }
  }

  get parentPage() {
    switch (true) {
      case this.router.currentRouteName.includes("category") ||
        this.router.currentRouteName.includes("Category"):
        return this.parentCategoryName;
      default:
        return null;
    }
  }

  get currentCategory() {
    this.categorySlugPathWithID =
      this.router?.currentRoute?.params?.category_slug_path_with_id;
    if (this.categorySlugPathWithID) {
      return Category.findBySlugPathWithID(this.categorySlugPathWithID);
    }
  }

  get categoryName() {
    if (this.currentCategory) {
      return this.currentCategory.name;
    }
  }

  get parentCategory() {
    this.parentCategoryId = this.currentCategory?.parentCategory?.id;
    if (this.parentCategoryId) {
      return Category.findById(this.parentCategoryId);
    }
  }

  get parentCategoryName() {
    if (this.parentCategory) {
      return this.parentCategory.name;
    }
  }

  get parentCategoryLink() {
    if (this.parentCategory) {
      return this.parentCategory.slug;
    }
  }

  <template>
    <div class="breadcrumbs">
      <div class="breadcrumbs__container">
        <ul>
          <li class="breadcrumbs__title">You are here
            {{icon "arrow-right"}}</li>
          <li class="breadcrumbs__home">
            <a href="/">Home</a>
          </li>

          {{#if this.parentPage}}
            <li class="breadcrumbs__item">
              <a href="/c/{{this.parentCategoryLink}}">
                {{this.parentPage}}</a>
            </li>
          {{/if}}

          {{#if this.currentPage}}
            <li class="breadcrumbs__item">
              {{this.currentPage}}
            </li>
          {{/if}}
        </ul>
      </div>
    </div>
  </template>
}
