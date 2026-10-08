<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Groups, type→group mapping, the block, and the notification_reference field

## `notification_group` config entity (`src/Entity/NotificationGroup.php`)
- `@ConfigEntityType` id `notification_group`, config prefix `notification_system.notification_group`,
  `admin_permission = "administer site configuration"`.
- Exported keys: `id`, `label`, `uuid`, `weight`; plus a `description` mapping
  (`{value, format}`, default format `full_html`) held on the entity and used by
  `getDescription()`. Sorted by `weight` (`postLoad`/`preSave` assign a trailing weight to new
  groups).
- UI: collection `/admin/structure/notification-group`, add/edit/delete forms (route provider
  `NotificationGroupHtmlRouteProvider`, list builder `NotificationGroupListBuilder`).
  `NotificationGroupForm` edits label, machine id, and a `text_format` description.
- Default install config: `config/install/notification_system.notification_group.default.yml`
  ("Default Group"). Schema: `config/schema/notification_group.schema.yml`.

## Type→group mapping (`src/Form/GroupMappingForm.php`)
- Route `notification_system.notification_groups.mapping` at
  `/admin/structure/notification-group/mapping`, permission `administer site configuration`.
- For every notification *type* (`NotificationSystem::getTypes()`) it renders a select of the
  available groups (plus "- None -"), and writes the result to
  `notification_system.settings:group_mappings` — a sequence of
  `{notification_type, notification_group}`. Schema in
  `config/schema/notification_system.settings.schema.yml`.
- This mapping drives `bundleNotifications()` (which group a notification renders under) and, in
  the dispatch submodule, per-group user delivery preferences.

## Block `notification_system_notifications` (`src/Plugin/Block/NotificationsBlock.php`)
- Category "Notification System". `blockAccess` allows **authenticated users only**.
- Settings (`defaultConfiguration`): `display_mode` (`simple`|`bundled`), `show_read`,
  `hide_empty`, `empty_message`, `disable_ajax`. Schema:
  `config/schema/notification_system.schema.yml` (`block.settings.notification_system_notifications`).
- `disable_ajax = FALSE` (default): renders a placeholder and attaches library
  `notification_system/notifications_block`; JS calls the get-notifications route and injects HTML.
  `drupalSettings.notificationSystem` carries `getEndpointUrl` and `markAsReadEndpointUrl`
  templates (`DISPLAY_MODE`, `PROVIDER_ID`, `NOTIFICATION_ID` placeholders).
- `disable_ajax = TRUE`: builds the notification list server-side via the controller
  (`buildRenderableNotifications`) using `router.no_access_checks` + `class_resolver`; adds cache
  context `user` and tag `notification_system:read:{uid}`.
- Theme hooks: `notification_block`, `notification_group`, `notification_item` (see
  `notification_system.module` `hook_theme`). Item titles/bodies are printed through ordinary
  autoescaping Twig templates in `templates/`.

## Field `notification_reference` (`src/Plugin/Field/…`)
A field type (+ default widget + formatter) that references a notification by two string columns,
`provider` and `notification_id`.
- **FieldType** `notification_reference`: properties `provider`, `notification_id`; `loadNotification()`
  resolves the referenced model via `plugin.manager.notification_provider`.
- **Widget**: radios of available providers + a text field for the id.
- **Formatter**: renders `nl2br(Html::escape("$provider: $notification_id"))`.
Used by the dispatch submodule's `notification_dispatch_bundle` entity to hold the notifications
queued for a user.

## Config objects at a glance
- `notification_system.settings` — `group_mappings` (sequence of type→group).
- `notification_system.notification_group.*` — one per group.
No `configure` route is declared in the core module's info.yml (groups live under Structure).
