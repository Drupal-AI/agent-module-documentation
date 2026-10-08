<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Push Framework (push_framework) — agent index

An orchestration layer for notifications. It does **not** deliver anything itself: it defines two
plugin types — **source** plugins (`Plugin/PushFrameworkSource`) that collect content items that need
pushing, and **channel** plugins (`Plugin/PushFrameworkChannel`) that render and send them (email,
SMS, Slack, push, … each shipped as a separate contrib module). The central `push_framework.service`
walks every source, deduplicates against a database-backed **Advanced Queue** (`queue_id`
`push_framework`, job type `pf_sourceitem`), and enqueues one `SourceItem` per (object, recipient).
On queue processing each `SourceItem` asks every *applicable, active* channel (in configured order) to
`prepareContent()` then `send()`, stopping at the first success so a user is not spammed across
channels. `push_framework_cron()` runs collect+process every cron; the same two steps are exposed as
drush `pf:sources:collect` and `pf:queue:process`.

Content for each channel is built from admin-set **subject/body token patterns** (config
`push_framework.settings`, or a per-channel `<channel>.settings` override) rendered through the entity
view builder in a chosen display mode; four `ChannelEvents` let other modules rewrite the templates
and rendered output. Users opt out via the `push_framework`/`block push` user-data flag (set by the
`Allow`/`Block` user actions, honored by both the collector and `hook_mail_alter`).

- Depends on: `advancedqueue:advancedqueue`, `drupal:node`, `drupal:text`, `drupal:user`.
- Core: `^10 || ^11`. Package: `Push`. PHP `>=8.1`.
- Settings page: **yes** — `push_framework.settings` at `/admin/config/system/push_framework`, gated by
  core permission **`administer site configuration`**. No module-defined permissions.
- Drush: **yes** (`pf:sources:collect`, `pf:queue:process`). Config schema: **no** (ships
  `config/install` defaults only). Provides plugin types: **`PushFrameworkChannel`**,
  **`PushFrameworkSource`**.
- Submodule **`eca_push_framework`** (installed): exposes a `ChannelPlugin`/DANSE recipient-selection
  derived per ECA "Push framework channel" event, so an ECA model's `DirectPush` event fires when that
  channel sends. Dev-suggested companions: `danse`, `eca`.

## What you'd do → where

- **Write a delivery channel (email/SMS/push/…) — the annotation, `ChannelBase`, `send()`,
  `applicable()`, per-channel config** → [plugins/channel.md](plugins/channel.md)
- **Write a source that feeds items into the queue (`getAllItemsForPush`, confirm callbacks)** →
  [plugins/source.md](plugins/source.md)
- **Drive it from code / cron / drush; the service, plugin managers, queue job, actions, migrate
  destination, DANSE, tokens, alter hooks** → [api/services.md](api/services.md)
- **Configure the notification templates, display modes and channel order; the config keys** →
  [configure/settings.md](configure/settings.md)
- **Alter the subject/body templates or rendered output while a notification is built** →
  [events/channel-events.md](events/channel-events.md)

## Key facts (real machine names)

- Route: `push_framework.settings` → `/admin/config/system/push_framework`
  (`_permission: administer site configuration`), form `Drupal\push_framework\Form\SettingsGeneral`
  (extends `Settings`, `getFormId()` = `push_framework_settings`).
- Services: `push_framework.service` (`Service`), `push_framework.channel.plugin.manager`
  (`ChannelPluginManager`), `push_framework.source.plugin.manager` (`SourcePluginManager`),
  `logger.channel.push_framework`.
- Plugin type **channel**: dir `Plugin/PushFrameworkChannel`, interface `ChannelPluginInterface`,
  base `ChannelBase`, annotation `@ChannelPlugin` (`Annotation\ChannelPlugin`), alter hook
  `push_framework_channel_info`. Config name convention `<plugin_id>.settings`; `RESULT_STATUS_SUCCESS`
  / `_RETRY` / `_FAILED`.
- Plugin type **source**: dir `Plugin/PushFrameworkSource`, interface `SourcePluginInterface`, base
  `SourceBase`, annotation `@SourcePlugin` (`Annotation\SourcePlugin`), alter hook
  `push_framework_source_info`.
- Queue: Advanced Queue id `push_framework` (backend `database`, auto-created), job type
  `pf_sourceitem` (`Plugin/AdvancedQueue/JobType/SourceItem`). Payload struct: `oid`, `uid`,
  `plugin id`, `initialized`, `tasks`.
- Drush: `pf:sources:collect`, `pf:queue:process` (`Drush\Commands\PushFrameworkCommands`).
- Action plugins (`type = user`): `push_framework_notify` (send a notification),
  `push_framework_notifications_allow`, `push_framework_notifications_block`.
- Events: class `ChannelEvents` — `push_framework.channel.prepare_templates`, `…pre_build`,
  `…pre_render`, `…post_render`.
- Config keys: `display_modes.<entity_type>`, `pattern.subject`, `pattern.body.value`,
  `pattern.body.format`, `order_<channel_id>`, plus per-channel `active`, `use_default_settings`.
- Tokens: type `push-object` with `[push-object:label]`, `[push-object:content]`
  (`push_framework.tokens.inc`).
- Hooks implemented: `hook_cron`, `hook_mail_alter`, `hook_token_info`/`hook_tokens`. User-data:
  module `push_framework`, key `block push` (`Service::BLOCK_PUSH`).
- Migrate destination: `push_framework_user_data` (`Plugin/migrate/destination/BlockPushUserData`).
