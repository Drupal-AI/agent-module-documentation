<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `drw_date_range` widget, its constraint and relative-date parsing

## Install & enable

```bash
composer require drupal/drw
drush en drw -y
```

No third-party Composer requirements (there is no `composer.json`). `drw.info.yml` declares no
`dependencies`, but the widget extends `Drupal\datetime\Plugin\Field\FieldWidget\DateTimeWidgetBase`,
so core **`datetime`** must be enabled and the target field must be a single-value **`datetime`**
field. There is no settings page — everything is per field on *Manage form display*.

## The widget (`DateRangeWidget`)

- Plugin id **`drw_date_range`**, label *"Date Range Widget"*, `field_types = { "datetime" }`, in
  `src/Plugin/Field/FieldWidget/DateRangeWidget.php`. Uses `DateParserTrait`.
- `formElement()` starts from the parent then:
  - forces date-only: `$element['value']['#date_time_element'] = 'none'` and
    `#date_time_format = ''` (no time/seconds shown or stored via the widget).
  - copies the field label/description onto the `value` sub-element.
  - adds `data-date-range-field="<field_name>"` attributes.
  - sets HTML5 `min`/`max` attributes by running each of `min_date`/`max_date` through
    `parseRelativeDate()` and formatting as `Y-m-d` (skipped if the string does not parse).
  - if a `required_error_message` is set and the element is required, sets
    `$element['value']['#required_error']`.
  - if `enable_custom_error_messages` is on, sets `$form['#attributes']['novalidate'] = 'novalidate'`
    on the **whole form** (disables browser HTML5 validation so server-side messages are shown).
- `settingsForm()` renders the settings below; `min_error_message`, `max_error_message` and
  `required_error_message` are `#states`-hidden unless *Enable custom error messages* is checked.
- `settingsSummary()` shows the configured min/max, or "No date range restrictions".

### Settings (`defaultSettings()` + config schema)

Config schema: `field.widget.settings.drw_date_range` in `config/schema/drw.schema.yml`.

| Setting key | Type | Default | Meaning |
|---|---|---|---|
| `min_date` | string | `''` | Minimum allowed date; absolute (`2000-01-01`) or relative (`today`, `-18 years`). Empty = no minimum. |
| `max_date` | string | `''` | Maximum allowed date; absolute or relative (`+1 year`, `2025-12-31`). Empty = no maximum. |
| `enable_custom_error_messages` | bool | `FALSE` | Reveals the three message fields; also adds `novalidate` to the form. |
| `min_error_message` | string (translatable) | `''` | Message when date < min. `@min` placeholder. Empty = default *"The date must be on or after @min."* |
| `max_error_message` | string (translatable) | `''` | Message when date > max. `@max` placeholder. Empty = default *"The date must be on or before @max."* |
| `required_error_message` | string (translatable) | `''` | Custom message when a required field is empty (drives `NotBlank`). Empty = core default. |

Example view-form-display config:

```yaml
# core.entity_form_display.node.event.default
content:
  field_event_date:
    type: drw_date_range
    settings:
      min_date: 'today'
      max_date: '+90 days'
      enable_custom_error_messages: true
      min_error_message: 'Please pick a date on or after @min.'
      max_error_message: 'Bookings close after @max.'
      required_error_message: 'A date is required.'
```

## How constraints are attached (`drw_entity_bundle_field_info_alter`)

In `drw.module`, `hook_entity_bundle_field_info_alter()` runs per entity type + bundle:

1. Lists all `core.entity_form_display.<entity>.<bundle>.*` configs, and for each field
   component whose `type === 'drw_date_range'` collects its (`array_filter`ed) settings.
2. For each such field present in `$fields`:
   - if `min_date` **or** `max_date` is set, adds constraint **`DateRange`** with
     `minDate`, `maxDate`, `minErrorMessage`, `maxErrorMessage`.
   - if `required_error_message` is set **and** the field `isRequired()`, adds core **`NotBlank`**
     with that custom `message`.

So the enforcement lives on the field definition (server-side), not only in the form element —
range checks apply to any save path that runs entity validation, and HTML5 `min`/`max` are just a
client-side convenience.

## The constraint + validator

- `DateRangeConstraint` (`src/Plugin/Validation/Constraint/DateRangeConstraint.php`), id
  **`DateRange`**, holds public props `minDate`, `maxDate`, `minErrorMessage`, `maxErrorMessage`
  (all default `''`).
- `DateRangeConstraintValidator` (`...Constraint/DateRangeConstraintValidator.php`) uses
  `DateParserTrait`, injects `@logger.factory`, registered in `drw.services.yml` with tag
  `validator.constraint_validator` (alias `DateRange`). `validate($item, $constraint)`:
  - returns early if the item/value is empty or an array.
  - parses `$item->value` as `DrupalDateTime`, returns on parse errors, then normalizes it to
    `setTime(0,0,0)` (date-only comparison).
  - if `minDate` set and parses: when `submitted < min`, adds a violation
    (`minErrorMessage` via `t(..., ['@min' => 'Y-m-d'])`, else the default message) and returns.
  - if `maxDate` set and parses: when `submitted > max`, adds a violation likewise with `@max`.
  - wraps the body in try/catch, logging any exception to the `drw` logger channel.
  - Comparison is **inclusive** (equal to min or max is allowed) and date-only (time ignored).

## Relative-date parsing (`DateParserTrait::parseRelativeDate`)

`src/DateParserTrait.php` is the single parser used by both the widget and the validator:

```php
$date = new DrupalDateTime($date_string, date_default_timezone_get());
return $date->hasErrors() ? NULL : $date;
```

- It relies entirely on core `DrupalDateTime` (which wraps PHP's `DateTime`/`strtotime`-style
  parsing). No `eval`, no `preg`, no shell — anything PHP's date parser understands works.
- Accepts absolute dates (`2000-01-01`, `YYYY-MM-DD`) and relative expressions (`today`, `now`,
  `-18 years`, `+90 days`, `+3 months`, `-2 weeks`, `+1 year`). Unparseable strings return `NULL`,
  which simply means "no bound applied" (widget skips the HTML5 attr; validator skips that check).
- Relative bounds are evaluated **at render/validation time** against the server's default
  timezone (`date_default_timezone_get()`), so e.g. `-18 years` always tracks "today − 18y".

## Operate / gotchas

- Applies only to core single `datetime` fields — **not** `datetime_range`, `daterange` or other
  field types.
- Enabling custom error messages disables HTML5 validation for the **entire form** (`novalidate`),
  relying on server-side validation; the widget's own description warns about this.
- Constraints are read from form-display config at bundle-field-info build time; after changing
  widget settings, clear caches (`drush cr`) if a stale constraint appears to linger.
- Min/max bounds are read from the **widget** settings; there is no field-storage or global config
  for them, so the same field reused in another display can have different rules.
