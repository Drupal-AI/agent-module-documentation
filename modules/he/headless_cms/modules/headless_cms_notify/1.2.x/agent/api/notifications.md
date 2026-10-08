<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Notify — services, messages, plugin type, events & hooks

## Dispatch flow

1. Core fires an entity hook or `hook_rebuild`.
2. `.module` calls `HeadlessNotifyService` (entity ops) or schedules
   `HeadlessNotifyRebuildAnnouncer` (cache rebuild).
3. `HeadlessNotifyService::sendNotifyMessage()` dispatches `BeforeHeadlessNotifyEvent`; if a
   subscriber aborts, it stops.
4. It asks `ConsumerHeadlessNotifyManager::getApplicableConsumers()` which consumers want this
   message type (and, for entity ops, this entity type).
5. For each applicable consumer it loads that consumer's transport and calls
   `HeadlessNotifyTransportService::send($message, $transport)`, which validates the transport and
   calls `$transport->getTransportPlugin()->send($message)`.

## Services (`headless_cms_notify.services.yml`)

- **`HeadlessNotifyService`** — `sendEntityOperationNotification(HeadlessNotificationEntityOperation
  $op, EntityInterface $entity)`, `sendCacheRebuildNotification()`, and the generic
  `sendNotifyMessage(HeadlessNotifyMessageInterface $message)`. Call these from custom code to emit
  notifications.
- **`HeadlessNotifyTransportService`** (`…TransportServiceInterface`, alias
  `headless_cms_notify.transport_service`) — `loadTransportPlugins()`, `send()`, `validate()`
  (throws if `HeadlessNotifyTransport::validate()` returns errors).
- **`ConsumerHeadlessNotifyManager`** — resolves per-consumer intent:
  `getApplicableConsumers(string $type, ?string $entityTypeId=NULL)` (cached in the
  `cache.headless_cms_notify` bin, keyed `applicable_consumers:<type>:<entityType>`, tagged with the
  consumers' cache tags), `isEnabled()`, `getNotifyTransport()`, `isNotificationEnabled()`,
  `canNotifyEntityType()`, `getEntityNotificationEntityTypes()`. Uses `consumer.negotiator` to pick
  the current consumer when none is passed.
- **`HeadlessNotifyRebuildAnnouncer`** — `scheduleAnnouncement()` registers `announce()` as a
  `drupal_register_shutdown_function` (idempotent per process), so the cache-rebuild notification is
  sent at end-of-process rather than mid-flush; failures are logged, not thrown.
- **`HeadlessNotifyMessageDiscoveryService`** — `getMessageTypes()` scans every module's
  `src/NotifyMessage` (via Symfony `Finder` + reflection), returning
  `HeadlessNotifyMessageDiscoveryResult` for each concrete `HeadlessNotifyMessageInterface`; cached
  in `cache.headless_cms_notify`. Feeds the consumer field's allowed values.

## Message types (`src/NotifyMessage`)

`HeadlessNotifyMessage` (abstract) holds `type`, `subType`, `params` and serialises via
`toArray()` / `toJson()` (`{type, subType, params}`). Concrete types must implement static
`getMessageTypeId()` / `getMessageTypeLabel()`:

- **`HeadlessNotifyEntityOperationMessage`** — id `entity_operation`; `subType` = entity type id;
  `params` = `{id, uuid, bundle, operation}` where operation ∈ `create|update|delete`
  (`HeadlessNotificationEntityOperation` enum).
- **`HeadlessNotifyCacheRebuildMessage`** — id `cache_rebuild`, no params.

Add a new event type by dropping a concrete class implementing `HeadlessNotifyMessageInterface`
into any module's `src/NotifyMessage`; it auto-appears as a selectable notification type.

## Plugin type `headless_cms_notify_transport`

- Manager `HeadlessNotifyTransportPluginManager` — dir `Plugin/HeadlessNotifyTransport`, interface
  `HeadlessNotifyTransportPluginInterface`, attribute `Attribute\HeadlessNotifyTransport(id, label)`,
  alter hook `headless_cms_notify_transport_info`.
- Base class `Plugin\HeadlessNotifyTransport\HeadlessNotifyTransportBase` — implements
  `ConfigurableInterface` + `DependentPluginInterface` + `ContainerFactoryPluginInterface`.
- Interface methods: `send(HeadlessNotifyMessageInterface $message): void` and `getLabel(): string`.
- Optional config form: implement `Plugin\HeadlessNotifyTransportPluginFormInterface`
  (extends core `PluginFormInterface`) — the entity form injects your `buildConfigurationForm()`.

Implement a transport by extending `HeadlessNotifyTransportBase`, adding the
`#[HeadlessNotifyTransport(id: '…', label: new TranslatableMarkup('…'))]` attribute, and (usually)
implementing `HeadlessNotifyTransportPluginFormInterface` to expose settings. See
`headless_cms_notify_webhook` / `headless_cms_notify_nats` for reference implementations.

## Event

`headless_cms_notify.before_notify` — `Event\BeforeHeadlessNotifyEvent`; `getMessage()` and
`abort()`/`isAborted()`. The built-in `HeadlessNotifyEventSubscriber` aborts when
`migrate_utils`'s `MigrateState::isMigrationRunning()` is true, unless the state flag
`headless_cms_notify.enable_notify_on_migrate` is set.

## Hooks (`headless_cms_notify.module`)

`hook_entity_insert/update/delete` (update skips new entities) → entity-operation notifications;
`hook_rebuild` → `HeadlessNotifyRebuildAnnouncer::scheduleAnnouncement()`;
`hook_form_consumer_form_alter` (moves the four fields into the Notify section, warns if no
transports exist); `hook_options_list_alter` (transport field labels); `hook_entity_base_field_info`
(adds the consumer fields).
