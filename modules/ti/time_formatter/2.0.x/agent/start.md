<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Time Formatter — agent index

One field **formatter** plugin, `number_time` ("Time"), that renders a numeric duration field
(seconds or milliseconds) as a time string. No settings page (`configure: null`), no
permissions, no Drush, no services, no plugin types.

- **The formatter id, its settings, output formats, and how to apply it** →
  [configure/formatter.md](configure/formatter.md)

Key facts:
- Formatter id `number_time`, field types `integer`, `decimal`, `float`.
- Settings (config schema `field.formatter.settings.number_time`):
  - `storage`: 0 = Seconds, 1 = Milliseconds (default **1**).
  - `display`: 0 = `123h 59m 59s 999ms`, 1 = `123h 59m 59s`, 2 = `123:59:59.999`, 3 = `123:59:59` (default **2**).
  - `hours`: 0 = Always, 1 = Optional (only if > 0), 2 = Never (default **0**).
- Applied on *Manage display* / in `core.entity_view_display.*` as the field component
  `type: number_time`.
