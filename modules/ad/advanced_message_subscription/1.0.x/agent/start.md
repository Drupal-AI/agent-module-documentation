<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Message Subscription (advanced_message_subscription) — agent index

A subscription framework on top of the **Message** module. Users subscribe to entities; on entity
insert/update/delete a message is created (and optionally sent) per matching subscription. Package
`Message`. Core `^11`. License GPL-2.0-or-later. Installed version 1.0.0-alpha9 (version dir `1.0.x`).

**Dependencies** (`*.info.yml`): `message:message`, `token:token`. Composer also requires
`drupal/token`. Optional runtime dep: `message_notify` (only needed to actually *send* notifications).
No routing.yml, no `.module` file — routes are generated from entity annotations; hooks are attribute
classes in `src/Hook/`.

## What it provides

- **Content entity** `advanced_message_subscription` (`src/Entity/AdvancedMessageSubscription.php`) —
  revisionable, owned (`uid`), published (`status`), `name` label. Bundle = subscription type.
- **Config (bundle) entity** `adv_message_subscription_type` (`src/Entity/AdvancedMessageSubscriptionType.php`) —
  a "subscription type" selecting + configuring one plugin; keys: `name_pattern`, `add_link_text`,
  `manage_link_text`, `notify`, `plugin`, `configuration`.
- **Plugin type** `AdvancedMessageSubscription` — attribute `src/Attribute/AdvancedMessageSubscription.php`,
  manager `src/AdvancedMessageSubscriptionPluginManager.php` (dir `Plugin/AdvancedMessageSubscription`,
  interface `AdvancedMessageSubscriptionPluginInterface`, alter `advanced_message_subscription_info`).
  Ships one plugin: `entity` (`src/Plugin/AdvancedMessageSubscription/Entity.php`).
- **Queue worker** `advanced_message_subscription_message` (`src/Plugin/QueueWorker/SubscriptionMessageQueueWorker.php`,
  cron 60s) → `SubscriptionProcessor::createMessage()`.
- **Event** `AdvancedMessageSubscriptionEvent` (plain object, not a Symfony event) dispatched by
  `src/Hook/EntitySubscriptionHooks.php` on entity_insert/update/delete.
- **Services** (`*.services.yml`): `plugin.manager.advanced_message_subscription`,
  `advanced_message_subscription.data_provider` (`DataProvider`),
  `advanced_message_subscription.link_generator` (`LinkGenerator`),
  `advanced_message_subscription.subscription_processor` (`SubscriptionProcessor`),
  and access checker `access_check.advanced_message_subscription.advanced_message_subscription_add`.
- **Permissions** (`*.permissions.yml`): `administer advanced_message_subscription types` (restricted),
  `manage own advanced_message_subscriptions`.
- **Config**: schema `config/schema/advanced_message_subscription.entity_type.schema.yml`; install
  ships two `system.action` bulk actions (save/delete subscriptions).
- **Hooks** (`advanced_message_subscription.api.php`): `_event_process`, `_query`, `_message_create`,
  `_message_post_create`, and `hook_message_notify_subscription_notify_cancel`.

## Routes (generated) & permissions

Subscription entity links (`Entity/AdvancedMessageSubscription.php` + `Routing/AdvancedMessageSubscriptionHtmlRouteProvider.php`):
collection `/admin/content/advanced-message-subscription` (admin perm), add `/subscription/add[/ {type}/{data}]`,
canonical `/subscription/{id}` **remapped to the edit form**, edit `/subscription/{id}`, delete
`/subscription/{id}/delete`, plus revision routes. Type routes under
`/admin/structure/adv_message_subscription_types`. Access details in the entities doc below.

## Solution docs

- Entity types, generated routes, permissions & access handlers →
  [entities/subscription.md](entities/subscription.md)
- Plugin type (attribute + manager + `entity` plugin) and how a subscription type is configured →
  [plugins/subscription-plugin.md](plugins/subscription-plugin.md)
- Event dispatch, SubscriptionProcessor, queue worker, message creation, hooks, LinkGenerator →
  [api/events-and-messaging.md](api/events-and-messaging.md)
