<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Field Timer — agent index

Four **field formatter plugins** for the core `datetime` field type that render the value
as a live timer/countdown. Configured per field per view mode on *Manage display*, stored in
`core.entity_view_display.<entity>.<bundle>.<mode>` → `content.<field>.type` +
`content.<field>.settings`. No settings form, no configure route, no permissions, no Drush.

- **The four formatters, their ids, settings keys, and library needs** →
  [plugins/formatters.md](plugins/formatters.md)
- **How to apply a formatter to a datetime field / where it is stored** →
  [configure/view-display.md](configure/view-display.md)

Formatter ids (all `field_types = { datetime }`):
`field_timer_simple_text` (Text timer or countdown — **no external library**, setting
`type: auto|timer|countdown`), `field_timer_countdown` (jQuery Countdown), and
`field_timer_countdown_led` (jQuery Countdown LED) — both need the **jQuery Countdown**
library at `libraries/jquery.countdown` — and `field_timer_county` (County) — needs the
**County** library at `libraries/county`.
