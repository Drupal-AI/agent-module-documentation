<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Syncloud (syncloud) — agent index

Captures Drupal site events — Commerce order placement, completed webform submissions, and
contact-form messages — as `syn` content-entity records, queues them on the `syncloud_queue`
Drupal queue, and publishes each as a JSON message to an external **MQTT** broker (topic
`$telega/syncloud/<uuid>/event/contact-message`, consumed downstream by a Telegram bridge).
Also injects a Matomo-style page-view tracking snippet and can annotate outgoing mail.

Package "Synapse". `core_version_requirement: ^11 || ^12`. Version dir `3.0.x` (release 3.0.6).

## Dependencies
- Drupal module: `contact` (declared in `syncloud.info.yml`).
- Composer library: `politsin/phpmqtt: ^1.0` (the MQTT client; not a Drupal module).
- Soft/optional at runtime (detected by class/`method_exists`, not declared): `commerce_order`
  + `state_machine` (order events), `webform` (submission events). Absence just means those
  event sources never fire.

## What it provides
- **Entity:** `syn` content entity (`src/Entity/Syn.php`) — base fields `name`, `mode`, `host`,
  `scheme`, `status`, `uid`, `created`, `changed`, `syn_id`, `type`, `message`
  (ref → `contact_message`), `ip`, `city`, `url`, `extra` (map). Handlers: `SynAccessControlHandler`,
  `SynListBuilder`, `SynViewBuilder`, `SynForm` (add/edit). Admin routes under
  `/admin/synapse/syn/*` and collection `/admin/content/syn`.
- **Config:** `syncloud.settings` (single object; no config schema shipped). Settings form
  `SynSettingsForm` at `admin/structure/syn`, route `entity.syn.settings`, perm `administer syn`.
- **Routes:** `entity.syn.settings` (settings form); `syncloud.queue` at `/syncloud/queue`
  (`_access: 'TRUE'`, `no_cache`) → `SyncloudQueueController::page()` drains the queue. Plus the
  entity CRUD routes from `AdminHtmlRouteProvider`.
- **Permissions** (`syncloud.permissions.yml`): `administer syn` (restricted), `access syn overview`,
  `create syn`, `view syn`, `edit syn`, `delete syn`.
- **Services** (`syncloud.services.yml`): `syncloud.mqtt` (`Service\MqttService`),
  `syncloud.queue` (`Service\Queue`), `syncloud.order_complete`
  (`EventSubscriber\OrderCompleteSubscriber`, tagged `event_subscriber`).
- **Hooks** (`syncloud.module` / `syncloud.install`): `hook_page_attachments`, `hook_theme`,
  `hook_contact_message_insert`, `hook_ENTITY_TYPE_insert`/`presave` (webform_submission),
  `hook_mail_alter`, `hook_cron`, `hook_requirements`. Hook bodies live in `src/Hook/*.php`.
- **Alter hooks it invokes:** `hook_syncloud_queue_preprocess_commerce`,
  `hook_syncloud_queue_preprocess_webform`, `hook_syncloud_queue_preprocess_contactform`.

## Known defects in 3.0.6 on Drupal 11.x (functional, not a doc omission)
Verified on Drupal 11.4.5:
- **Entity field incompatibility → site-wide HTTP 500.** The `syn` base field `message` is an
  `entity_reference` to `contact_message`, which has no `id` entity key in current core, so
  `EntityReferenceItem::propertyDefinitions()` throws `FieldException` whenever `syn` field
  definitions are computed. In practice every web page (front end and admin) returns HTTP 500 while
  the module is enabled; CLI/`drush` (including cron) still runs. Fix: point `message` at a storable
  entity type (or drop the reference).
- **Queue service DI type error.** `Service\Queue::__construct()` type-hints argument 2 as
  `Drupal\Core\Queue\QueueFactoryInterface`, but `@queue` resolves to
  `Drupal\Core\Queue\QueueFactory` on Drupal 11 → `TypeError` whenever the `syncloud.queue` service
  is built, independently breaking `/syncloud/queue` and every enqueue call. Fix: type-hint
  `QueueFactory`.

The weekly-usage cron publish (`Hook\Cron` → `syncloud.mqtt`) does not depend on either broken path.

## Changes vs 8.x-2.x
- `core_version_requirement` narrowed from `^9 || ^10 || ^11` to `^11 || ^12`.
- Config `configure` route unchanged (`entity.syn.settings`).
- Composer now requires `politsin/phpmqtt: ^1.0` (recorded in `composer_requirements`).
- No config schema is shipped (`provides_config_schema: false`).

## Solution docs
- [config/settings.md](config/settings.md) — settings form, `syncloud.settings` keys, MQTT
  connection sourcing, page-attachment snippet, mail alter.
- [entity/syn.md](entity/syn.md) — the `syn` entity: fields, handlers, access, routes, permissions.
- [api/event-queue-flow.md](api/event-queue-flow.md) — how events become queue jobs and get
  published (subscriber + hooks → `Queue` → `MqttService`), cron, and the alter hooks.
