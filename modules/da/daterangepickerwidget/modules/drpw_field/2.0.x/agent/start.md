<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DateRangePicker Field Type (drpw_field) — agent index

Field-type sub-module of the **daterangepickerwidget** project. Adds the `daterangepicker` field
type plus its widget, formatter and Views filter/sort handlers. Package `Field types`. Core
`^10 || ^11`. GPL-2.0-or-later. Version 2.0.x. Depends on the base module `daterangepickerwidget`
(and Views for the filter/sort handlers).

## What it provides

- **Field type** `daterangepicker` — `DateRangePickerItem` (`src/Plugin/Field/FieldType/`),
  `#[FieldType(id: 'daterangepicker', cardinality: 1, default_widget: 'daterangepicker_default',
  default_formatter: 'daterangepicker_default')]`. One `value` column: `varchar(255)`, nullable,
  holding JSON `{"start":"yy-mm-dd","end":"yy-mm-dd"}`. → [fields/field.md](fields/field.md).
- **Widget** `daterangepicker_default` — `DateRangePickerDefaultWidget` (`…/FieldWidget/`), renders
  the base picker via `DateRangePickerTrait`, exposes the shared options form.
  → [fields/field.md](fields/field.md).
- **Formatter** `daterangepicker_default` — `DateRangePickerDefaultFormatter` (`…/FieldFormatter/`),
  decodes the JSON and renders two `<time>` elements with a PHP `date_format` + `range_splitter`.
  → [fields/field.md](fields/field.md).
- **Views filter** `views_daterangepicker_filter` + **sort** `views_daterangepicker_sort` — wired
  onto `daterangepicker` columns by `drpw_field_views_data_alter()` in `drpw_field.module`.
  → [views/views.md](views/views.md).

## Facts an agent needs

- **Config schema**: `config/schema/drpw_field.schema.yml` defines
  `field.widget.settings.daterangepicker_default` and `field.formatter.settings.daterangepicker_default`.
- No routes, permissions, services, Drush, or config entities.
- The internal storage/`alt_format` is hard-pinned to `yy-mm-dd` in the widget code — do not change.
- Views SQL uses MySQL/MariaDB `JSON_EXTRACT`/`JSON_UNQUOTE` (+ `DATEDIFF` for the interval sort);
  values are bound as placeholders.
