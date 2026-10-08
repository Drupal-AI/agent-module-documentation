<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Forum Notifications Subscription (forum_notifications_subscription) — agent index

Adds per-user email subscriptions to core **Forum**. A "Subscribe / Unsubscribe" AJAX action link is
attached (as an extra display field) to forum containers (`taxonomy_term` bundle `forums`) and forum
topics (`node` bundle `forum`); clicking it hits `ActionLinkController::subscribe`/`unsubscribe`,
which create/delete a `forum_notification_frequency` content entity that records *this user*, the
subscribed entity, the type (`Forum` / `Forum topic`) and a frequency (`Single Emails` /
`Daily Digest Emails`). When a new forum topic is posted (`hook_entity_insert`) or a comment is added
(`hook_comment_insert`), the module loads every subscriber's frequency row, renders a tokenized
subject/body from configurable templates, and either sends immediately, queues a single email, or
appends to that user's daily-digest queue item. Two `QueueWorker` cron plugins
(`single_email_queue`, `daily_digest_email_queue`) drain the queues; the digest worker holds items
until midnight in the recipient's timezone and concatenates the day's posts/comments into one email.

Users manage their own frequencies from a **fieldset injected into the user account edit form**
(`hook_form_user_form_alter`), or via the shipped Views `your_subscription_settings`. Subscriptions
are auto-created for the poster/commenter, deleted when the topic node is deleted, and purged when a
user is blocked/deactivated.

- Depends on: `forum:forum` (core Forum, which pulls in taxonomy, node, comment).
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Notifications`.
- Settings page: **yes** — `configure` route `forum_notifications_subscription.settings`
  (`/admin/config/system/forum_notifications_subscription`, `administer site configuration`).
- Permissions: defines **no** `*.permissions.yml`. Uses core `access content` (action links) and
  `administer site configuration` (settings). The `forum_notification_frequency` entity's annotation
  references `administer/view/edit/delete/add … frequency entities` permissions that are **never
  declared**, so the admin entity UI is reachable only by user 1 / a role with all permissions.
- Drush: none. Plugin types defined: none (it *provides* two `QueueWorker` plugin instances, not a
  new plugin type). Config schema: yes.
- Content entity type: **`forum_notification_frequency`** (base table `forum_notification_frequency`),
  with full admin routes under `/admin/structure/forum_notification_frequency`.

## What you'd do → where

- **Customize button labels, email subjects/bodies, default frequency, cron behavior** →
  [configure/settings.md](configure/settings.md)
- **Enable the subscribe link on a forum / topic display; understand the action-link routes, the
  AJAX controller and the render link** → [api/routes.md](api/routes.md)
- **Call the subscription service from code; the `forum_notification_frequency` entity fields &
  admin UI; the token service** → [api/services.md](api/services.md)
- **Understand how a new topic/comment fans out into emails; the user-profile subscription manager;
  the queue workers & digest batching** → [api/notifications.md](api/notifications.md)
- **Use the `fns_topic` / `fns_comment` / `fns_dd` tokens in the email templates** →
  [api/tokens.md](api/tokens.md)

## Key facts (real machine names)

- Routes: `forum_notifications_subscription.settings`
  (`/admin/config/system/forum_notifications_subscription`, settings form),
  `forum_notifications_subscription.action_link_subscription`
  (`/forum/subscription/{entity_type_id}/{entity_id}`),
  `forum_notifications_subscription.action_link_unsubscription`
  (`/forum/unsubscription/{entity_type_id}/{entity_id}`) — both action links require `access content`.
  Entity routes auto-generated under `entity.forum_notification_frequency.*` +
  `forum_notification_frequency.settings`.
- Controller: `Drupal\forum_notifications_subscription\Controller\ActionLinkController`
  (`subscribe`, `unsubscribe`, static `getSubscriptionLink`, `getResponse` — returns an
  `AjaxResponse` with a `ReplaceCommand`).
- Services: `forum_notifications_subscription.frequency`
  (`ForumNotificationsSubscriptionService`, implements `…ServiceInterface`),
  `forum_notifications_subscription.token` (`ForumNotificationsSubscriptionTokenService`, wraps core
  `token`).
- Content entity: `forum_notification_frequency` (`Entity\Frequency` implements `FrequencyInterface`);
  handlers: list builder `ForumNotificationFrequencyListBuilder`, access handler
  `ForumNotificationFrequencyAccessControlHandler`, route provider
  `ForumNotificationFrequencyHtmlRouteProvider`, views data
  `Entity\ForumNotificationFrequencyViewsData`, forms `ForumNotificationFrequencyForm` /
  `ForumNotificationFrequencyDeleteForm` / `FrequencySettingsForm`. Base fields: `user_id`, `name`,
  `type`, `entity_id`, `entity_name`, `frequency`, `status`, `created`, `changed`, `uuid`, `langcode`.
- QueueWorker plugins: `single_email_queue` (`SingleEmailQueue`, cron time 90),
  `daily_digest_email_queue` (`DailyDigestEmailQueue`, cron time 100).
- Queues used: `single_email_queue`, `daily_digest_email_queue` (core `queue` service).
- Mail: `hook_mail` keys `single_email_queue`, `daily_digest_email_queue` (from `dd_email_queue`),
  plus direct `emailer('single_email_queue', …)` for non-cron single sends.
- Extra display field id: `forum_notifications_subscription` (on `node.forum` and
  `taxonomy_term.forums` view displays) — hook_entity_extra_field_info.
- Token types: `fns_topic`, `fns_comment`, `fns_dd`. Cache tag: `forum_notification_frequency_list`.
- Config object: `forum_notifications_subscription.settings` (keys: `forum_label_on/off`,
  `topic_label_on/off`, `post_subject`, `post_message`, `post_dd_message`, `comment_subject`,
  `comment_message`, `comment_dd_message`, `dd_subject`, `dd_header_message`,
  `forum_default_frequency`, `topic_default_frequency`, `cron`).
- Shipped View: `your_subscription_settings` (base table `forum_notification_frequency`).
- Hooks: `entity_extra_field_info`, `node_view`, `taxonomy_term_view`, `form_user_form_alter`,
  `entity_insert`, `node_delete`, `comment_insert`, `entity_presave`, `mail`, `token_info`, `tokens`,
  `help`. Install: `update_8100` (sets module weight 9999).
