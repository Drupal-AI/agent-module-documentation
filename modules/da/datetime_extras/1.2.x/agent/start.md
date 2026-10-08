<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Extras — agent index

Extends core `datetime`/`datetime_range` with a **time-only field type**, extra **widgets**,
and a **formatter**. No settings form, no `configure` route, no permissions, no services, no
Drush. Everything is configured per field on *Manage form display* / *Manage display*, stored
as field storage/widget/formatter settings in field + display config.

- **Field type, widgets, formatter it adds; ids, settings, where to select them** →
  [configure/fields-and-widgets.md](configure/fields-and-widgets.md)

Quick reference (plugin ids):

| Kind | id | Applies to | Notes |
|---|---|---|---|
| Field type | `time_only_field` | — | stores time only (`datetime_type: time`); default widget+formatter `time_only_field_default` |
| Widget | `time_only_field_default` | `time_only_field` | time input |
| Formatter | `time_only_field_default` | `time_only_field` | `format_type`, `timezone_override` |
| Widget | `datetime_datelist_no_time` | `datetime` | date select lists, **no** time |
| Widget | `datatime_configurable` | `datetime` | `year_range`, `increment` |
| Widget | `datatime_extras_configurable_list` | `datetime` | **deprecated** |
| Widget | `daterange_duration` | `daterange` | start + **duration**; needs `duration_field` module |

`daterange_duration` is hidden by `hook_field_widget_info_alter()` unless a modern
`duration_field` (>= 8.x-2.0-rc3) is enabled.
