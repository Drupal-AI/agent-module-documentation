<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DANSE — Drupal Audit Notification Subscription Event — is a framework that turns system activity into auditable events, builds notifications from them, and lets users subscribe to exactly the events they care about.

---

Most notification modules pick one source (content changes, say) and one delivery (email) and hard-wire the path between them. DANSE separates the three concerns — event, subscription, notification — and makes each pluggable through two plugin types (`@Danse` event sources and `@DanseRecipientSelection` recipient selectors), which is why it ships as a base module plus eight submodules: **danse_content** for entity create/update/delete/publish/unpublish and comments, **danse_config** for configuration-entity saves, **danse_user** for user and role/permission changes, **danse_form** for form submissions, **danse_log** for log entries, **danse_generic** for arbitrary events raised in code, **danse_webhook** for an inbound REST endpoint that lets remote systems create events, and **eca_danse** for ECA integration (extra events plus ECA-driven recipient selection). Something noticeable becomes a `danse_event` content entity, subscriptions are stored per user in `user.data`, and matching recipients receive `danse_notification` entities shown on-site (and optionally pushed via Push Framework). Users manage what they follow at `/user/{user}/subscriptions` and see their inbox in a block or profile tab; administrators configure the framework at `/admin/config/system/danse`, choose recipient plugins per source, and keep the tables in check with a companion **prune** form and cron-based pruning. Requirements are PHP 8.1+ and core `^10.3 || ^11`; ECA and Push Framework are optional integrations rather than hard dependencies. Drush commands create outstanding notifications on demand and pause or resume event tracking around bulk operations.

---

- Notify users when content they follow changes.
- Let users subscribe to specific events, role-gated per bundle.
- Give editors a per-entity follow / unfollow button.
- Build a notifications inbox block for each user.
- Provide a self-service subscription centre in the user profile.
- Follow a single node, term, or comment thread for updates.
- Notify moderators of new content submissions.
- Audit configuration-entity changes.
- Record who changed what and when, as an activity log.
- Track user account and role/permission changes.
- Subscribe administrators to log entries of a given severity.
- Report on all system activity through the shipped Views.
- Create events remotely by POSTing to the webhook endpoint.
- Notify a shared user base from an external system (Discourse, Zendesk).
- Drive recipient selection from an ECA workflow.
- Push notifications to external channels via Push Framework.
- Audit form submissions across the site.
- Prune old events, notifications, and actions on a schedule.
- Pause event tracking during a migration or bulk import.
- Extend the framework with a custom event-source plugin.
- Add a custom recipient-selection strategy.
- Auto-mark notifications seen when the subject is viewed.
