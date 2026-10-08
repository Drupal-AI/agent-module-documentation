<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Datetime Timezone (datetime_timezone) — agent index

A date **field type + widget + formatter** that store and display a user-chosen **timezone**
alongside each date value. The field type `datetime_timezone` extends core `datetime`'s
`DateTimeItem`, adding a second storage column, `timezone` (varchar 255), next to the UTC `value`.
The widget adds a region-grouped timezone `<select>`; on submit it reinterprets the entered
wall-clock time as being *in the selected zone* before core converts it to UTC for storage, and on
re-edit it converts the stored UTC value back into the saved zone so the editor sees the same local
time. The formatter re-applies the stored timezone when rendering, so a value entered as "7pm in
Tokyo" shows as 7pm regardless of the site or viewer timezone.

**Why:** core stores datetimes in UTC and displays them in the site/viewer zone — correct for a
timestamp (a moment that happened), wrong when the zone is part of the meaning (a local event time).
This makes the timezone data the editor selects, not a display preference. It is a **separate field
type**, not a setting on core's, so there is **no in-place upgrade** from an existing `datetime`
field — adopting it for existing content is add-a-field-and-migrate. Decide before content exists.

- Depends on: `drupal:datetime` (core).
- Core: `^10.1 || ^11`. Package: `Field types`.
- No settings page / `configure` route, no permissions, no services, no drush, no hooks, no routes.
  All configuration is per field-widget and per field-formatter (form/display config).
- Provides config schema. Defines **no** new plugin types (uses core's field type/widget/formatter
  plugin types).

## What you'd do → where

- **Add a zoned date field, wire up the widget and formatter, understand storage/conversion and the
  settings keys** → [fields/field.md](fields/field.md)

## Key facts (real machine names)

- Field type: `datetime_timezone` (`Plugin\Field\FieldType\DateTimeTimezoneItem`, extends
  `datetime`'s `DateTimeItem`) — `default_widget = datetime_timezone`,
  `default_formatter = datetime_timezone_default`, `list_class` =
  `\Drupal\datetime\...\DateTimeFieldItemList`. Adds property/column `timezone` (string / varchar 255).
- Field widget: `datetime_timezone` (`Plugin\Field\FieldWidget\DateTimeTimezoneWidget`, extends
  `datetime`'s `DateTimeDefaultWidget`) — `field_types = {datetime, datetime_timezone}`.
- Field formatter: `datetime_timezone_default` (`Plugin\Field\FieldFormatter\DateTimeTimezoneDefaultFormatter`,
  extends abstract `DateTimeTimezoneFormatterBase`) — `field_types = {datetime_timezone}`.
- Formatter setting key: `format_type` (a `date_format` entity id; default `medium`).
- Config schema keys: `field.storage_settings.datetime_timezone` (inherits `datetime`, incl.
  `datetime_type`), `field.value.datetime_timezone` (inherits `datetime`),
  `field.formatter.settings.datetime_timezone_default` (`format_type`).
- Services used (core, injected in the formatter): `date.formatter`, `entity_type.manager`
  (loads `date_format` storage). No services *provided*.
