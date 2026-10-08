<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Symfony Messenger integration (sm) — agent index

Integrates the **Symfony Messenger** component into Drupal so code can dispatch messages onto a
message **bus** and have them handled either synchronously (in-request) or asynchronously via a
**transport** (a queue). SM wires the full Symfony Messenger stack — buses, middleware, transports,
retry/failure handling, a standalone `bin/sm` console app, and message-handler autodiscovery — into
the Drupal service container, primarily through service providers and compiler passes
(`SmServiceProvider` adds `SmMessageHandlerCompilerPass`, `SmCompilerPass`, Symfony's own
`MessengerPass`, and `SmUnprivatizeTransportsCompilerPass`). It ships a native **Drupal SQL
transport** (`drupal-sql://`) that stores queued messages in an auto-created database table, and can
optionally **intercept the legacy Drupal Queue API** so existing `@QueueWorker` items route through
the bus instead.

Configuration is done with **container parameters** (`sm.buses`, `sm.transports`, `sm.routing`,
`sm.default_bus`, `sm.failure_transport`) declared in a site `services.yml`, or through the optional
**`sm_config`** submodule which stores per-message routing in Drupal config and exposes a form at
`/admin/config/messenger/routing`. Message handlers are plain classes in a module's `src/Messenger/`
directory carrying the `#[AsMessageHandler]` attribute; they are discovered on container rebuild
(`drush cr`) and run with full site privileges. This is developer infrastructure — an alternative to
core's Queue API with Symfony's routing, middleware, retries, deduplication and rate limiting.

- Depends on: nothing (base `sm`). Requires composer libs `symfony/messenger`, `symfony/lock`,
  `symfony/property-access`, `symfony/runtime` (`symfony/rate-limiter` optional). Submodule
  `sm_config` depends on `sm:sm`.
- Core: `^10.5 || ^11.2`. PHP `>=8.2`. Package: `Messenger`.
- No formal `configure` route on the base module (configured via YAML parameters). Base module
  defines **no permissions**; `sm_config` adds one restricted permission and the routing form.
- **Commands are a standalone Symfony console app** (`vendor/bin/sm` / `bin/sm`), NOT Drush:
  `messenger:consume`, `messenger:stats`, `messenger:failed:show|retry|remove`.
- Defines **no Drupal plugin type**. Message handlers are Symfony message handlers (attribute-based),
  transports are Symfony transport factories — not Drupal plugins.
- Provides config schema (via `sm_config`). Legacy-queue interception is opt-in via `settings.php`.

## What you'd do → where

- **Configure buses, transports, routing, failure transport, rate limiting (YAML params or the
  `sm_config` UI + permission)** → [configure/settings.md](configure/settings.md)
- **Write a message + handler, dispatch on a bus, deduplicate, or intercept the core Queue API** →
  [api/dispatch.md](api/dispatch.md)
- **Understand the Drupal SQL transport: DSN, options, table/schema, failed messages, retries** →
  [api/transports.md](api/transports.md)
- **Run the consume / stats / failed-message commands (`bin/sm`)** → [api/console.md](api/console.md)

## Key facts (real machine names)

- Routes: `symfony_messenger.config` (`/admin/config/messenger`, perm `access administration pages`,
  a `SystemController` admin-menu landing page); `sm_config.settings`
  (`/admin/config/messenger/routing`, perm `administer sm_config configuration`, form
  `Drupal\sm_config\Form\SmRoutingConfigForm`) — the latter only when `sm_config` is enabled.
- Container parameters (config keys): `sm.default_bus` (default `sm.bus.default`), `sm.buses`,
  `sm.transports`, `sm.routing`, `sm.failure_transport` (default `failed`).
- Default transports (install `sm.services.yml`): `synchronous` (`sync://`), `asynchronous`
  (`drupal-sql://default`), `failed` (`drupal-sql://default?queue_name=failed`).
- Public/autowirable services: `messenger.default_bus` (alias → `sm.bus.default`),
  `Symfony\Component\Messenger\MessageBusInterface` (→ default bus), `messenger.routable_message_bus`
  (+ `Symfony\Component\Messenger\RoutableMessageBus`, NOT autowired), `logger.channel.sm`,
  `sm.queue_interceptor.queue_item_factory` (alias → `Drupal\sm\QueueInterceptor\SmLegacyQueueFactory`).
- Per-bus service naming: each key in `sm.buses` becomes service `sm.bus.<key>`
  (`Symfony\Component\Messenger\MessageBus`, tagged `messenger.bus`).
- Drupal SQL transport DSN `drupal-sql://default`; options/DSN-query keys: `table_name`
  (default `sm_messages`), `queue_name` (default `default`), `redeliver_timeout` (default `3600`),
  `auto_setup` (default `true`). Factory `Drupal\sm\Transport\DrupalSql\TransportFactory`.
- Serializer: `messenger.transport.native_php_serializer` (Symfony `PhpSerializer`) =
  `messenger.default_serializer`.
- Message handler discovery: classes under a module's `src/Messenger/` (recursive) with
  `#[AsMessageHandler]` on the class or a public method; autowired; discovered by
  `SmMessageHandlerCompilerPass` on container rebuild.
- Deduplication: dispatch with `Symfony\Component\Messenger\Stamp\DeduplicateStamp('id')`; backed by
  `DrupalDeduplicatingLockStore` over `lock.persistent` (name prefix `sm-`).
- Legacy queue interception: set `$settings['queue_default'] =
  \Drupal\sm\QueueInterceptor\SmLegacyQueueFactory::class;` — message `SmLegacyDrupalQueueItem`,
  handler `Drupal\sm\Messenger\SmLegacyDrupalQueueItemMessageHandler`.
- State/DB: created message tables tracked in State `sm_tables` (`MessageTableTracker`); dropped on
  uninstall (`sm_uninstall()` → `MessageTableTracker::dropAll()`).
- `sm_config` permission: `administer sm_config configuration` (`restrict access: true`); config
  object `sm_config.settings` (schema key `routing`).
