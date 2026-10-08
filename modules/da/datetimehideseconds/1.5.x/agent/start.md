<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DateTime Hide Seconds — agent index

Adds a per-widget **"Hide seconds"** checkbox to core Date/time field widgets. When on, the
time input only accepts `HH:MM` (HTML5 `step=60`). No settings form, no configure route, no
plugins, no Drush, no permissions. Its only persistent state is a **third-party setting** on
a datetime widget in an `entity_form_display` config entity.

- **Turn "Hide seconds" on for a datetime field / read where it is stored** →
  [configure/hide-seconds.md](configure/hide-seconds.md)
- **How the mechanism works (hooks, render element, `step=60`) and which widgets it targets** →
  [api/mechanism.md](api/mechanism.md)

Key fact: the setting lives at
`core.entity_form_display.<entity>.<bundle>.<form_mode>` →
`content.<field>.third_party_settings.datetimehideseconds.hide: true`, and only appears for
widgets extending `DateTimeWidgetBase` (`datetime_default`, `datetime_datelist`, and the
Datetime Range widgets).
