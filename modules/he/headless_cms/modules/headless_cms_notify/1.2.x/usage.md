<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Notification framework for Headless CMS that sends entity-operation and cache-rebuild events to decoupled frontends through pluggable, per-consumer transports.

---

Headless CMS - Notify is the engine that lets a decoupled frontend react to changes in Drupal. It hooks core's `hook_entity_insert/update/delete` and `hook_rebuild` and, for each configured API consumer, dispatches a message describing what changed. Delivery is abstracted behind a `headless_cms_notify_transport` plugin type and a `headless_notify_transport` config entity, so the actual channel — a webhook, a NATS subject, or a custom plugin — is chosen per consumer without changing this module. Configuration is stored on the `consumer` entity: four base fields (enabled, transport, notification types, entity types) added to the Consumers admin form let you say "consumer X wants entity_operation notifications for node and media over the Production webhook". Message types are discovered automatically by scanning every module's `src/NotifyMessage` directory, so third-party modules can add their own event types. Two message types ship: `entity_operation` (create/update/delete, carrying id/uuid/bundle/operation) and `cache_rebuild`. Cache-rebuild notifications are deferred to a shutdown function so the network call never runs mid-flush against a cold site. A `BeforeHeadlessNotifyEvent` allows subscribers to abort a send — used with `migrate_utils` to silence notifications during migrations. This submodule provides no transport of its own; enable Notify - Webhook or Notify - NATS (or write a plugin).

---

- Notify a frontend whenever a node/media/any entity is created, updated or deleted.
- Trigger a static-site rebuild or CDN revalidation when Drupal's caches are rebuilt.
- Route different consumers' notifications to different transports.
- Limit entity-operation notifications to selected entity types per consumer.
- Turn notifications on or off per consumer without code changes.
- Manage delivery channels as exportable `headless_notify_transport` config entities.
- Add a custom delivery channel by implementing a `headless_cms_notify_transport` plugin.
- Add a custom event/message type by dropping a class in a module's `src/NotifyMessage`.
- Abort or modify a notification before it is sent via `BeforeHeadlessNotifyEvent`.
- Suppress all entity notifications while a migration runs (with `migrate_utils`).
- Send a cache-rebuild ping after every `drush cache:rebuild` during deploys.
- Send notifications programmatically from custom code via `HeadlessNotifyService`.
- Reuse the same message across many consumers efficiently (applicable-consumer caching).
- Give each frontend team their own transport + event subscription.
- Fan out one entity change to multiple consumers at once.
- Build event-driven incremental rebuilds for Next.js / Nuxt / Astro frontends.
- Keep a search index or edge cache in sync with Drupal content changes.
