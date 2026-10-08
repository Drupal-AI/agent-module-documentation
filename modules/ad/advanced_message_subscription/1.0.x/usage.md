<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Advanced Message Subscription lets users subscribe to entities and receive Message-module notifications when those entities change, via a configurable subscription entity type, a subscription plugin type, entity-event dispatch and a queue worker that creates one message per matching subscription.

---

The module defines a content entity type `advanced_message_subscription` whose bundles are configuration entities of type `adv_message_subscription_type` ("subscription types"). Each subscription type selects one `AdvancedMessageSubscription` plugin and configures it; the plugin decides who is subscribed to what and how messages are built. The module ships a single plugin, `entity`, which subscribes a user to a specific content entity referenced through an entity-reference base/bundle field, and can restrict the subscription to a chosen entity type and bundles. When any entity is inserted, updated or deleted, `EntitySubscriptionHooks` dispatches an `AdvancedMessageSubscriptionEvent`; `SubscriptionProcessor::processEvent()` loads all subscription types using the matching plugin, asks each plugin to `findSubscriptions()`, and enqueues an item per subscription on the `advanced_message_subscription_message` queue (a cron queue worker, 60s). The worker calls `SubscriptionProcessor::createMessage()`, which creates a `message` entity from the subscription-type-configured message template (per event type: insert/update/delete), owned by the subscriber, and — when the type has "notify" enabled and the `message_notify` module is installed — sends the notification as the subscriber. A `LinkGenerator` renders a subscribe-or-manage link for a subscription type and entity (offered as an extra field on the subscribed entity's display via `entity_extra_field_info` / `entity_view`). Subscriptions are owned content entities: creating one requires the `manage own advanced_message_subscriptions` permission (the generated add form), and viewing/editing/deleting one additionally requires being its owner; managing subscription types requires `administer advanced_message_subscription types`. The module exposes four `hook_advanced_message_subscription_*` hooks plus a notify-cancel hook, a token integration for subscription names, and default `system.action` config for bulk save/delete of subscriptions.

---

- Notify a user by message whenever a specific node they subscribed to is updated.
- Let users "follow" a piece of content and get a message on each edit.
- Send a message when a subscribed-to entity is deleted (e.g. "the event you followed was removed").
- Build a per-entity "Subscribe / Manage subscription" link that appears on the node display.
- Restrict a subscription type to one entity type and a set of bundles (e.g. only `event` nodes).
- Route different message templates per event: one template for inserts, another for updates.
- Turn subscriptions into email/other notifications by enabling `message_notify` and the type's "notify" flag.
- Let each subscriber manage only their own subscriptions from a "manage" link.
- Give site editors a `/admin/content/advanced-message-subscription` list of all subscriptions.
- Bulk-delete or bulk-save subscriptions with the provided VBO-style entity actions.
- Auto-name new subscriptions from a token pattern (e.g. include the subscribed entity's title).
- Populate a reference field on the created message pointing back at the subscribed entity.
- Populate a reference field on the created message pointing back at the subscription itself.
- Add a custom subscription mechanism by implementing a new `AdvancedMessageSubscription` plugin.
- Cancel processing of an event conditionally (e.g. skip on certain days) via the event-process hook.
- Alter the subscription-lookup entity query per event (e.g. omit users who silenced a type) via the query hook.
- Set a message field (e.g. an expiry timestamp) as each message is created via the message-create hook.
- Trigger an external side effect (SMS, webhook) after a message is created via the post-create hook.
- Suppress a single notification per subscription via the notify-cancel hook (e.g. honor a "send mail" field).
- Enforce that a user can only subscribe to entities they can view (default "Check access" on the entity plugin).
- Batch message creation through cron so large subscriber sets are processed in a queue rather than inline.
- Expose subscriptions to Views (the entity provides `EntityViewsData`) for custom subscriber reports.
- Track subscription revisions (the entity is revisionable with a full revision UI).
