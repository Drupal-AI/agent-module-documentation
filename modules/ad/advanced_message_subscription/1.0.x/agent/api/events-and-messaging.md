<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Events, processing, queue, messaging, hooks & links

## The event object

`src/AdvancedMessageSubscriptionEvent.php` — a plain value object (NOT a Symfony event, not dispatched
through the event dispatcher). Constructed with `pluginId`, `eventType` (e.g. `insert`/`update`/
`delete`), an `EntityInterface`, an optional `AccountInterface` (defaults to current user) and a `data`
array; captures a `timestamp` from `\Drupal::time()`. Accessors: `getPluginId()`, `getEventType()`,
`getEntity()`, `getAccount()`, `getData($key = NULL)`, `getTimestamp()`, plus `cancel()` /
`canProcess()` to short-circuit processing.

## Trigger → processing (synchronous part)

`src/Hook/EntitySubscriptionHooks.php` (attribute hooks) fires on **every** entity:

- `#[Hook('entity_insert' | 'entity_update' | 'entity_delete')]` → builds
  `new AdvancedMessageSubscriptionEvent('entity', <op>, $entity)` and calls
  `SubscriptionProcessor::processEvent($event)`.

`src/SubscriptionProcessor.php::processEvent()`:
1. Invokes `hook_advanced_message_subscription_event_process($event)`; returns early if
   `$event->canProcess()` is FALSE (a hook may `cancel()`).
2. `AdvancedMessageSubscriptionTypeStorage::loadByPluginId($event->getPluginId())` → all subscription
   types using that plugin.
3. Per type: get the plugin; skip unless `getEventMessageTemplate($event)` returns a template.
4. For each subscription id yielded by `$plugin->findSubscriptions($event, $type)`, enqueue an item on
   the **`advanced_message_subscription_message`** queue carrying: `plugin_id`, `event_type`,
   `timestamp`, `entity_id`, `entity_type_id`, `entity_label`, `uid`, `data`, `message_template`,
   `subscription_id`.

So message creation is deferred to cron/queue, not done inline with the triggering save.

## Queue worker → message creation

`src/Plugin/QueueWorker/SubscriptionMessageQueueWorker.php` —
`#[QueueWorker(id: 'advanced_message_subscription_message', cron: ['time' => 60])]`. `processItem()`
loads the `message_template` and the `advanced_message_subscription`, then calls
`SubscriptionProcessor::createMessage($template, $subscription, $data)`.

`SubscriptionProcessor::createMessage()`:
1. Creates a `message` entity: `template` = the configured template, `uid` = the subscription owner,
   `created` = the event timestamp.
2. If the plugin implements `MessageCreationInterface`, calls `initializeNewMessage()` (the `entity`
   plugin seeds optional back-reference fields on the message via `MessageEntityTrait`).
3. Invokes `hook_advanced_message_subscription_message_create($message, $subscription, $data)`
   (message not yet saved — mutate fields here).
4. `$message->save()`, then `sendNotification()`, then
   `hook_advanced_message_subscription_message_post_create(...)`.

`sendNotification($message, $subscription, $force = FALSE)`:
- Returns if the message owner is not authenticated, or if `message_notify` is not installed.
- Temporarily switches the current user to the message owner (for tokens/timezone), restoring after.
- Unless `$force`, returns if the subscription type's `notify()` is off; otherwise invokes
  `hook_message_notify_subscription_notify_cancel(...)` and, if no hook returns a truthy (cancel)
  value, calls `message_notify.sender->send($message)`.

## Hooks (`advanced_message_subscription.api.php`)

- `hook_advanced_message_subscription_event_process($event)` — inspect/`cancel()` an event before it
  is processed.
- `hook_advanced_message_subscription_query($query, $event, $subscription_type)` — alter the
  entity query used to find subscriptions (e.g. exclude users who silenced a type).
- `hook_advanced_message_subscription_message_create($message, $subscription, $data)` — alter the
  message before it is saved.
- `hook_advanced_message_subscription_message_post_create($message, $subscription, $data)` — react
  after save + notify (e.g. send SMS).
- `hook_message_notify_subscription_notify_cancel($message, $subscription): ?bool` — return truthy to
  suppress a single notification.

## Subscribe / manage links

`src/LinkGenerator.php::getLinkArray($type, $query_data, $link_data, $account)`:
- Calls `$type->getPlugin()->getUserSubscription($type, $account, $query_data, FALSE)`.
- If a subscription exists → link to `$subscription->toUrl()` (its edit/manage page), title =
  `$type->getManageLinkText()`. Otherwise → `Url::fromRoute('entity.advanced_message_subscription.add_form',
  ['adv_message_subscription_type' => $type->id()])` with the `data` route param set to `$link_data`,
  title = `$type->getAddLinkText()`.
- Adds `?destination=<current>` (redirect back), sets `#access` from `$url->access($currentUser)` (so
  the link only shows when the route access — permission + ownership/target access — passes), and
  attaches the `user` cache context plus a per-type/per-user list cache tag.

These links are surfaced as an **extra field** on subscribable entities:
`EntitySubscriptionHooks::subscriptionLinkInfo()` (`#[Hook('entity_extra_field_info')]`) declares one
display component per `entity`-plugin subscription type that has `extra_field_display` on, for each
configured (or all) bundle of the configured entity type; `displaySubscriptionLinks()`
(`#[Hook('entity_view')]`) renders it via the LinkGenerator when the display component is enabled.

## `DataProvider`

`src/DataProvider.php` wraps a `RouteMatchInterface`; `getDataParam()` returns the `{data}` route
parameter (the `"<entity_type>:<id>"` string the `entity` plugin parses). Service:
`advanced_message_subscription.data_provider`.
