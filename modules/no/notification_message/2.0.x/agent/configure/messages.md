<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure notification messages

There is no single settings form. You work with three things: **message types** (bundles),
**messages** (content), and the **block** that displays them.

## Message types (bundles) — `notification_message_type`

Config entity, prefix `notification_message.type.<id>`. Managed at
`/admin/structure/notification-message-types` (perm `administer notification message types`).
A `global` type ships in `config/install/notification_message.type.global.yml`.

Exported keys (schema `notification_message.type.*`):

| Key | Type | Meaning |
|---|---|---|
| `id`, `label` | string | Machine name / human label. |
| `help`, `description` | text | Shown on the type/add forms. |
| `allow_condition` | bool | Whether messages of this type may attach Condition plugins. |
| `condition_datatype` | sequence<string> | Context data types the condition UI offers. |
| `notification_dismiss.show` | bool | Show a dismiss (close) button on messages. |
| `notification_dismiss.button_text` | string | Dismiss button label (default `Close`). |

Types are Field UI bundles (`field_ui_base_route` = the type edit form), so you can add extra
fields (image, link, severity…) to a type via *Manage fields*.

## Messages — `notification_message` content entity

Managed at `/admin/content/notification-message` (perm `administer notification message
content`). Base fields: `label` (required), `message` (text_long), `uid` (defaults to current
user), `publish_start_date` (required, default `now`), `publish_end_date` (required, default
`+2 day`), `conditions` (map, populated when `allow_condition` is on), `conditions_required`
(bool — all vs any). A message shows only while now is inside the start/end window.

### Create a message with Drush

```php
// drush php:eval
$m = \Drupal::entityTypeManager()->getStorage('notification_message')->create([
  'type' => 'global',
  'label' => 'Scheduled maintenance',
  'message' => ['value' => 'The site will be down Sunday 02:00–03:00 UTC.', 'format' => 'basic_html'],
  'publish_start_date' => '2026-08-10T02:00:00',   // stored UTC (DATETIME_STORAGE_FORMAT)
  'publish_end_date'   => '2026-08-11T00:00:00',
]);
$m->save();
```

## The block

Place the **Notification messages** block (plugin `notification_message`) in a region via
*Block layout* (`/admin/structure/block`). Block settings (schema
`block.settings.notification_message`):

- `notification_message.type` — array of type ids to show; **empty = show all types**.
- `notification_message.display_mode` — the `notification_message` view mode used to render
  each message (e.g. `full`).

The block query loads only messages whose window is current, then filters each through
`isPublished()`, an entity `view` access check, and `evaluateConditions()` before rendering.
See [../api/entity.md](../api/entity.md).
