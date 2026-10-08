<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Entity Notify (entity_notify) — agent index

Sends **email and/or Telegram** notifications when entities are **created, updated, or deleted**.
Implements `hook_entity_insert` / `hook_entity_update` / `hook_entity_delete`; each fires
`_entity_notify_event($entity, $event)` in `entity_notify.module`. Version dir **1.x** (installed
release 1.3.0). Core `^10 || ^11`. License GPL-2.0-or-later.

- **Dependency:** `telegram_api:telegram_api` (composer `drupal/telegram_api:^2.0`) — supplies the
  `telegram_api.service` used for Telegram delivery. Email uses core mail only.
- **Config entity:** none. Settings live in the simple config object `entity_notify.settings`
  plus **third-party settings** on node types and comment types.
- **Plugins:** none provided. **Drush:** none.

## What it provides

- **Route / form:** `entity_notify.settings` → `/admin/config/system/entity_notify`
  (`\Drupal\entity_notify\Form\EntityNotifySettingsForm`, a `ConfigFormBase`). Menu link under
  *Configuration › System*.
- **Permission:** `administer entity_notify configuration` (only permission; gates the settings
  form). Node/comment per-bundle settings are gated by core's *administer content/comment types*.
- **Config object:** `entity_notify.settings` (schema in `config/schema/entity_notify.schema.yml`;
  install defaults `enable: true`, `ignore_paths: ''`).
- **Third-party settings:** namespace `entity_notify` on `node.type.*` and `comment.type.*`
  (schema `node.type.*.third_party.entity_notify`, `comment.type.*.third_party.entity_notify`).
- **hook_mail** key `entity_notify_new_event`; helper `_entity_notify_send_mail($to, $params)`.
- **Updates:** `entity_notify_update_10001–10003` (migrate node/comment settings to per-bundle;
  add `enable` and `ignore_paths`).

## Solution docs

- **Global settings, config object, schema, route & permission** →
  [config/settings.md](config/settings.md)
- **Per-bundle (node/comment type) and other-entity-type configuration** →
  [config/per-bundle.md](config/per-bundle.md)
- **Trigger flow, recipient resolution, and email/Telegram delivery** →
  [api/notifications.md](api/notifications.md)
