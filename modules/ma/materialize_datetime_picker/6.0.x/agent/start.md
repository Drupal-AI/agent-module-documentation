<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bootstrap Materialize DateTime Picker (materialize_datetime_picker) — agent index

**Materialize-styled datetime field widget + form element with configurable hours format, granularity, disabled days/dates and start-of-week.**

- **Version:** 6.0.x
- **Core:** ^8 || ^9 || ^10 || ^11
- **Dependencies:** drupal:datetime
- **Widget:** `materialize_date_time_widget` (datetime fields); **Element:** `materialize_date_time`
- **Routes:** `materialize_datetime_picker.materialize_datetime_picker_config` → `/admin/config/materialize/datetime_picker_config` and an admin index, both perm `access administration pages`
- **Config:** `materialize_datetime_picker.site_config_datetime` (global defaults)
- **Security:** Admin config routes gated by `access administration pages` (broad but only writes module config). No PHP-side external fetch, no SQL, no anonymous mutating endpoints. NOTE: the JS library pulls assets from external CDNs (bootstrapcdn, cdnjs, momentjs.com, fonts.googleapis.com) — a third-party/CDN supply-chain & privacy consideration, not a code vulnerability.

See [configure/widget.md](configure/widget.md)