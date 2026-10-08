<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Date Range Widget (drw) — agent index

A field widget for **core single-value `datetime` fields** that enforces a configurable
**minimum and/or maximum allowed date**. Bounds may be absolute (`2000-01-01`) or relative
(`today`, `-18 years`, `+90 days`), parsed by `DrupalDateTime`. Package `Field`. Core
`^10 || ^11`. License GPL-2.0-or-later. Version 1.1.3 (dir `1.1.x`).

- **The widget, its settings, the constraint/validator, relative-date parsing, the hook and
  service** → [fields/date-range-widget.md](fields/date-range-widget.md)

## What it actually is

- **No routes, no permissions, no Drush, no config entities, no submodules, no JS, no external
  deps.** `drw.info.yml` declares no `dependencies`; the widget nonetheless requires core
  **`datetime`** at runtime (it extends `Drupal\datetime\...\DateTimeWidgetBase`).
- The name "Date Range" = the *allowed range a single date must fall within*. It is **not** a
  two-date start/end widget and does **not** enforce start-before-end.

## Provides

- **Field widget** `drw_date_range` (label "Date Range Widget"), `field_types = { "datetime" }`,
  in `src/Plugin/Field/FieldWidget/DateRangeWidget.php` (extends core `DateTimeWidgetBase`).
  Forces date-only entry; emits HTML5 `min`/`max`; adds `novalidate` when custom messages are on.
- **Validation constraint** `DateRange` (`src/Plugin/Validation/Constraint/DateRangeConstraint.php`)
  + validator `DateRangeConstraintValidator.php` (server-side min/max enforcement).
- **Trait** `Drupal\drw\DateParserTrait::parseRelativeDate()` — the only date parser, used by both
  the widget and the validator.
- **Hook** `drw_entity_bundle_field_info_alter()` in `drw.module` — dynamically attaches the
  `DateRange` (and optional `NotBlank`) constraint to fields configured with this widget.
- **Service** in `drw.services.yml`: the validator, tagged `validator.constraint_validator`
  (alias `DateRange`), arg `@logger.factory`.
- **Config schema** `field.widget.settings.drw_date_range` (`config/schema/drw.schema.yml`).

## Settings (widget, per Manage form display)

`min_date`, `max_date` (absolute or relative strings), `min_error_message`, `max_error_message`,
`required_error_message` (all translatable), `enable_custom_error_messages` (bool). Defaults are
empty / FALSE. Details in [fields/date-range-widget.md](fields/date-range-widget.md).
