<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled Entity Notifications lets visitors of a decoupled front-end subscribe by email to changes on specific Drupal entities and receive notifications when those entities are updated.

---

Decoupled Entity Notifications (DEN) exposes a small JSON API (`/api/v1/de_notifications/*`) for a headless front-end to subscribe an email address to a Drupal entity, confirm the subscription (double opt-in), unsubscribe from one or all entities, and request an overview of a subscriber's subscriptions. Subscribing is only allowed on entities whose bundle carries the module's `notification_settings` field with subscription enabled. Content editors set that field's "Send notification" flag and a "Changes" description when they save an entity; on `hook_entity_update` the module queues a notification for every confirmed subscriber of that entity (and an "archived" notice when it is unpublished). Confirm/unsubscribe/overview links are authenticated by signed JWT tokens (HS256) whose secret comes from `de_notifications.settings:secret_key`; token TTLs are configurable. Two content entity types — `de_notifications_subscriber` (email, IP, bounce count) and `de_notifications_subscription` (subscriber + Dynamic Entity Reference to the target entity + language + confirmed flag) — store the data, with Views integration and admin list builders. Delivery is pluggable through the `notification_type` plugin type; the bundled `de_notifications_symfony_mailer` submodule delivers the six notification kinds as Symfony Mailer emails with mailer policies you can theme.

---

- Add subscribe-to-changes capability to a decoupled/headless Drupal front-end.
- Let anonymous visitors register an email to be notified when a node or other entity is updated.
- Enable subscribing per entity bundle by adding the `notification_settings` field.
- Turn subscribing on or off for an individual entity via the field's "Subscription enabled" checkbox.
- Have a content editor mark "Send notification" and describe the changes when saving an entity.
- Run a double opt-in flow: subscribe, email a JWT-signed confirm link, confirm.
- Expose JSON endpoints for subscribe, confirm, unsubscribe, unsubscribe-all, and overview.
- Let a subscriber unsubscribe from a single entity via a tokenized link.
- Let a subscriber unsubscribe from every entity at once (`unsubscribe/all`).
- Email a subscriber a full overview of their active subscriptions on request.
- Deliver notifications only for the entity translation/language the user subscribed to.
- Queue notifications for confirmed subscribers when an entity is updated (via cron queue worker).
- Notify subscribers when a subscribed entity is unpublished/archived, then clean up.
- Automatically prune unconfirmed subscriptions older than the confirm-token TTL on cron.
- Track a bounce count per subscriber for deliverability handling.
- Store subscriptions against any entity type using Dynamic Entity Reference.
- Manage subscribers and subscriptions in the admin UI (list builders, delete/save actions).
- Report on subscriptions and subscriber counts through the shipped Views.
- Send notifications as email using the Symfony Mailer submodule (DENSM).
- Customize confirm/unsubscribe email content by editing Symfony Mailer policies.
- Add UTM or other query parameters to entity links inside notifications.
- Point notification links at your front-end base URL and relative paths.
- Extend delivery to other channels by writing a new `notification_type` plugin.
- Configure token time-to-live separately for confirm links and generic links.
- Respect entity view access when returning entity labels in API responses.
