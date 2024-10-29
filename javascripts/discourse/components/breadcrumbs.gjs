/*
 * Component extended from https://github.com/denvergeeks/discourse-breadcrumb-links
 */
import Component from "@glimmer/component";
import { getOwner } from "@ember/application";
import { inject as service } from "@ember/service";
import icon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";

export default class Breadcrumbs extends Component {
  @service router;

  getCategoryInfo(category) {
    if (!category) {return null;}
    return {
      name: category.name,
      url: `/c/${category.slug}/${category.id}`,
    };
  }

  get currentPageInfo() {
    const route = this.router.currentRouteName;

    switch (true) {
      case route === "discovery.categories":
        return { name: i18n("js.category.all"), url: null };
      case route.includes("userPrivateMessages"):
        return { name: i18n("js.groups.messages"), url: null };
      case route.startsWith("admin"):
        return { name: i18n("js.admin_title"), url: null };
      case route.startsWith("chat"):
        return { name: i18n("js.chat.heading"), url: null };
      case route === "userNotifications.responses" ||
        route === "userNotifications.mentions":
        return { name: i18n("js.groups.mentions"), url: null };
      case route === "userActivity.bookmarks":
        return { name: i18n("js.user.bookmarks"), url: null };
      case this.router?.currentRoute?.parent?.name === "docs":
        return { name: i18n("js.docs.title"), url: null };
      case this.router?.currentRoute?.parent?.name === "preferences":
        return { name: i18n("js.user.preferences.title"), url: null };
      case route === "discourse-post-event-upcoming-events.index":
        return {
          name: i18n("js.discourse_post_event.upcoming_events.title"),
          url: null,
        };
      case route === "tags.index":
        return { name: i18n("js.tagging.all_tags"), url: null };
      case route.includes("Category") || route.includes("category"):
        const category =
          this.router.currentRoute.attributes?.category ||
          this.router.currentRoute.parent?.attributes?.category;
        return this.getCategoryInfo(category);
      case route.includes("discovery.top"):
        return { name: i18n("js.filters.top.title"), url: null };
      case route === "user.summary":
        return { name: i18n("js.user.summary.title"), url: null };
      case route.includes("userActivity"):
        return { name: i18n("js.user.activity_stream"), url: null };
      case route === "userNotifications.index":
        return { name: i18n("js.user.notifications"), url: null };
      case route === "userInvited.show":
        return { name: i18n("js.user.invited.title"), url: null };
      case route === "user.badges":
        return { name: i18n("js.badges.title"), url: null };
      case route.includes("topic.fromParams"):
        const topicController = getOwner(this).lookup("controller:topic");
        if (topicController && topicController.model) {
          return {
            name: topicController.model.title,
            url: null,
          };
        }
        break;
      default:
        return null;
    }
  }

  get parentPageInfo() {
    switch (true) {
      case this.router.currentRouteName.includes("category") ||
        this.router.currentRouteName.includes("Category"):
        const parentCategory =
          this.router.currentRoute.attributes?.category.parentCategory;
        return this.getCategoryInfo(parentCategory);

      case this.router.currentRouteName.includes("topic.fromParams"):
        const topicController = getOwner(this).lookup("controller:topic");
        return this.getCategoryInfo(topicController?.model?.category);

      default:
        return null;
    }
  }

  get grandParentPageInfo() {
    switch (true) {
      case this.router.currentRouteName.includes("topic.fromParams"):
        const topicController = getOwner(this).lookup("controller:topic");
        const ancestors = topicController.model.category.ancestors;
        return ancestors.length > 1 ? this.getCategoryInfo(ancestors[0]) : null;

      default:
        return null;
    }
  }

  // Computed properties for backward compatibility
  get currentPage() {
    return this.currentPageInfo?.name ?? null;
  }

  get parentPage() {
    return this.parentPageInfo?.name ?? null;
  }

  get grandParentPage() {
    return this.grandParentPageInfo?.name ?? null;
  }

  get parentPageUrl() {
    return this.parentPageInfo?.url ?? null;
  }

  get grandParentPageUrl() {
    return this.grandParentPageInfo?.url ?? null;
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

          {{#if this.grandParentPage}}
            <li class="breadcrumbs__item">
              <a href={{this.grandParentPageUrl}}>
                {{this.grandParentPage}}
              </a>
            </li>
          {{/if}}

          {{#if this.parentPage}}
            <li class="breadcrumbs__item">
              <a href={{this.parentPageUrl}}>
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
