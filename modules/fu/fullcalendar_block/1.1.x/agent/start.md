<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FullCalendar Block — agent index

Provides one block plugin, `fullcalendar_block`, that renders a FullCalendar 5 calendar from a JSON
event-feed URL. Depends on `block` + `datetime`. No configure route (place the block), no permissions, no
Drush, no plugin types. Per-instance config lives in the `block.block.<id>` config entity.

- **Block settings keys, schema, defaults, and placing/configuring it via drush** →
  [configure/block.md](configure/block.md)
- **`hook_fullcalendar_block_settings_alter()` and the JS build events** → [hooks/alter.md](hooks/alter.md)
- **The `fullcalendar_block` theme hook / template** → [theming/template.md](theming/template.md)

Key facts: plugin id `fullcalendar_block` (block category "Calendar"); schema
`block.settings.fullcalendar_block`; required setting `event_source` (JSON feed URL); `initial_view`
defaults to `dayGridMonth`; `plugins` enables `moment`/`rrule`; `advanced`/`advanced_drupal` are YAML/JSON.
