<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Read Time — agent index

Adds an estimated reading-time display to nodes, computed from text + Paragraphs and a
words-per-minute rate. One config object `node_read_time.settings`; settings page at
`/admin/config/reading-time` (route `system.admin_config_reading_time`). No permissions, no
Drush, no plugin types.

- **Config keys, per-type activation, WPM, unit formats, how to display, recipes** →
  [configure/settings.md](configure/settings.md)
- **The ReadingTime service, computed base field, Views field** →
  [api/reading-time.md](api/reading-time.md)
- **The `reading_time` theme hook / template** →
  [theming/reading-time.md](theming/reading-time.md)

Key facts:
- Config `node_read_time.settings` → `reading_time.{container.<type>.is_activated,
  words_per_minute, unit_of_time}`. WPM defaults to 225 when empty.
- Display: activated types get an **extra field** `reading_time` on Manage display; also a
  computed base field `node_read_time` and a Views field "Node read time".
- `unit_of_time`: `default`, `minute`, `second`, `below`.
