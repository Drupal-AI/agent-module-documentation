<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DateTime Range Until Now (datetime_range_until_now) — agent index

Adds an explicit **"Until now"** (ongoing / open-ended) third state to a Date Range field, so a period
that has started but not ended is stored as data rather than faked with an empty or far-future end
date. It works two ways at once. It ships a standalone field type `daterange_until_now` (with a
matching widget and formatter), and — more importantly — three `hook_*_info_alter()` implementations
in `datetime_range_until_now.module` **retrofit core's own Date Range** onto the module's classes:
`hook_field_info_alter` swaps the `daterange` field-type class to `DateRangeUntilNowItem`,
`hook_field_widget_info_alter` swaps the `daterange_default` widget to `DateRangeUntilNowWidget`, and
`hook_field_formatter_info_alter` swaps the `daterange_default` formatter to
`DateRangeUntilNowFormatter`. (Runtime-confirmed: the core `daterange` type's class resolves to
`DateRangeUntilNowItem` once this module is enabled.)

The retrofit adds a boolean **storage setting** `until_now` ("Provide until now") to Date Range field
storage, an `until_now` tinyint DB column plus a computed `until_now` property to the field, makes
`end_value` nullable, gives the widget an "Until now" checkbox (and drops the required flag on the end
date), and makes the formatter render `start – Until now` when that checkbox is set. On install a
`hook_install()` migrates **existing** `daterange` field tables in place (nullable `_end_value`, new
`_until_now` column). The agent entry point is entirely the Field UI / entity edit form — enable the
storage setting, tick the widget checkbox — there are no routes, services, or a settings page.

- Depends on: `datetime_range` (core; itself needs core `datetime`).
- Core: `^9 || ^10 || ^11`. Package: `Field types`. Version `1.0.0`.
- No settings page (`configure` = null). No permissions. No drush. No services. No routes. No render elements.
- Defines **no plugin types** (it adds Field API plugins, not new managers).
- Provides config schema: `field.storage_settings.daterange` gains the `until_now` key.

## What you'd do → where

- **Add/enable the "Until now" option on a Date Range field; understand the field type, widget,
  formatter, storage setting, DB column and the retrofit/install behavior** →
  [fields/fields.md](fields/fields.md)

## Key facts (real machine names)

- Field type: `daterange_until_now` (`Plugin/Field/FieldType/DateRangeUntilNowItem`, extends core
  `Drupal\datetime\Plugin\Field\FieldType\DateTimeItem`; `default_widget = daterange_until_now`,
  `default_formatter = daterange_default`, `list_class` = core `DateRangeFieldItemList`). The same
  class is also bound to core's `daterange` type by `hook_field_info_alter`.
- Field widget: `daterange_until_now` ("Date range until now",
  `Plugin/Field/FieldWidget/DateRangeUntilNowWidget`, extends `DateRangeWidgetBase`). Also bound to
  core's `daterange_default` widget by `hook_field_widget_info_alter`.
- Field formatter: `daterange_until_now` (label "Default",
  `Plugin/Field/FieldFormatter/DateRangeUntilNowFormatter`, extends `DateTimeDefaultFormatter`, uses
  `DateTimeRangeTrait`). Also bound to core's `daterange_default` formatter by
  `hook_field_formatter_info_alter`.
- Storage setting: `until_now` (boolean, default `FALSE`). Field property/DB column: `until_now`
  (`int` `tiny`, `not null`, default `0`, indexed); `end_value` made nullable and not required.
- Formatter setting: `separator` (default `-`), rendered as `start <separator> Until now`.
- Hooks: `hook_field_info_alter`, `hook_field_widget_info_alter`, `hook_field_formatter_info_alter`
  (all in `datetime_range_until_now.module`), `hook_install`, `hook_update_8001`.
- Config schema key: `field.storage_settings.daterange` (extends `field.storage_settings.datetime`),
  `config/schema/datetime_range_until_now.schema.yml`.
- No security surface (no routes, controllers, services, permissions, or external I/O).
