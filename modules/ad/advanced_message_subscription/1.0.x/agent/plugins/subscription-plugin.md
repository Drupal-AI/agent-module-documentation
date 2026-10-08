<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The AdvancedMessageSubscription plugin type

## Discovery

Attribute-based plugin type (`src/AdvancedMessageSubscriptionPluginManager.php`):

- Subdir `Plugin/AdvancedMessageSubscription`; interface
  `AdvancedMessageSubscriptionPluginInterface`; attribute `Attribute/AdvancedMessageSubscription`
  (`id`, `label`, `description`, `deriver`); alter hook `advanced_message_subscription_info`; cache key
  `advanced_message_subscription_plugins`.
- Service `plugin.manager.advanced_message_subscription` (also aliased to the class name).
- **ID constraint** (documented on the attribute): the plugin id must equal the group or be prefixed
  `group:...` — i.e. `entity` or `entity:...`.

A subscription **type** (`adv_message_subscription_type`) stores the chosen `plugin` id and its
`configuration`; `AdvancedMessageSubscriptionType::getPlugin()` instantiates it via a
`DefaultSingleLazyPluginCollection`. Set the plugin + config through the type form
(`Form/AdvancedMessageSubscriptionTypeForm.php`, AJAX-driven plugin config fieldset).

## Interface / base class

`AdvancedMessageSubscriptionPluginInterface` (extends `ConfigurableInterface`) methods:
`getEventTypes()`, `getRequiredData()`, `requiredDataAvailable()`, `checkBundle()`, `createAccess()`,
`applySubscriptionData()`, `getUserSubscription()`, `getCacheTags()`, `findSubscriptions()`,
`getEventMessageTemplate()`. `AdvancedMessageSubscriptionPluginBase` provides:

- `\Drupal::` service accessors (entity type manager, field manager, bundle info, module handler,
  current user, `advanced_message_subscription.data_provider`).
- `defaultConfiguration()` merged into `configuration` via `NestedArray::mergeDeep` in
  `setConfiguration()`.
- `createAccess()` (base): `AccessResult::allowedIf(checkBundle && requiredDataAvailable)` +
  the type as cache dependency. Subclasses AND their own checks onto this.
- `buildEventTypesFormElement()`: per event type, a `status` checkbox + `message_template` select
  (options from `message_template` entities); stored under `configuration.event_types[<type>]`.
- `getEventMessageTemplate($event)`: returns the configured template id for the event's type, or NULL
  if that event type is not enabled.

## The shipped `entity` plugin

`src/Plugin/AdvancedMessageSubscription/Entity.php` — `#[AdvancedMessageSubscription(id: 'entity')]`,
implements `MessageCreationInterface`, uses `MessageEntityTrait`. Subscribes a user to a single content
entity referenced from a field on the subscription.

`defaultConfiguration()`: `field_name` (the entity-reference field ON the subscription bundle that
holds the subscribed entity), `entity_type`, `entity_bundles`/`bundles`, `extra_field_display` (TRUE),
`access_check` (TRUE), `access_operation` (`view`). The config form also collects `entity_field_name`
and `subscription_field_name` — optional reference fields ON the *message* to backfill (see messaging
doc). `getEventTypes()` = insert/update/delete.

Key methods:

- `checkBundle($type)`: TRUE only if the configured `field_name` exists on the bundle and is an
  `entity_reference` field.
- `getRequiredData($dataProvider)`: parses the route `{data}` param as `"<entity_type>:<id>"`, loads
  the entity only if its type matches `configuration.entity_type` and (if set) its bundle is in
  `configuration.bundles`; returns `['entity' => …|NULL]`. `requiredDataAvailable()` = that entity is a
  loaded `ContentEntityInterface`.
- `createAccess($type, $dataProvider)`: base access (`checkBundle && requiredDataAvailable`) AND, when
  `configuration.access_check` is on, the **target entity's own access** for
  `configuration.access_operation` (default `view`) — so by default a user can only subscribe to an
  entity they may view.
- `applySubscriptionData($subscription)`: on create, sets the `field_name` reference to the resolved
  entity (called from the entity's `postCreate()`).
- `getUserSubscription($type, $account, $data, $active_only)`: entity-query for a subscription owned by
  the account, of this bundle, whose reference field points at `$data['entity']` (optionally
  `status = 1`); `accessCheck(FALSE)` but scoped to the owner id, returns one or NULL. Used by the
  LinkGenerator to decide add-vs-manage.
- `findSubscriptions($event, $type)`: generator; skips unless an event-type message template is
  configured and the event entity type matches; pages by ascending id (query is `accessCheck(FALSE)`
  because this runs server-side during event processing) and invokes
  `hook_advanced_message_subscription_query` so other modules can constrain the audience.
- `initializeNewMessage($message, $subscription, $data)`: sets the message's `entity_field_name` ref
  to the subscribed entity and `subscription_field_name` ref to the subscription (via
  `MessageEntityTrait::setMessageEntityRefFromConfig`).
- `getCacheTags()`: merges the referenced entity's cache tags into the subscription's.

## Writing a new plugin

Create `src/Plugin/AdvancedMessageSubscription/MyThing.php` with
`#[AdvancedMessageSubscription(id: 'my_thing', label: new TranslatableMarkup('…'))]` extending
`AdvancedMessageSubscriptionPluginBase` (implement the interface methods; implement
`MessageCreationInterface` if you need to seed message fields). Dispatch your own
`AdvancedMessageSubscriptionEvent('my_thing', $event_type, $entity)` to
`SubscriptionProcessor::processEvent()` when your trigger fires.
