<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Widgets & the widget framework

This module does **not** define a new plugin *type*. It provides three
`@FieldWidget` plugins for the existing `date_recur` field type, plus base
classes/traits meant to be copied when building your own widget.

## The three bundled widgets

All declare `field_types = {"date_recur"}` and nothing else — they only attach to
Recurring Dates Field (`date_recur`) fields.

| Plugin id | Label | Class | Notes |
|---|---|---|---|
| `date_recur_modular_alpha` | Modular: Alpha | `DateRecurModularAlphaWidget` | Drupal states + CSS. Modes: non-recurring, multiday, weekly (interval 1, fortnightly=2, multi-weekday, count/until limit), monthly (ordinal). No settings. |
| `date_recur_modular_oscar` | Modular: Oscar | `DateRecurModularOscarWidget` | "Opening hours" variant; range stays within one day. Setting: `all_day_toggle` (bool, default TRUE). |
| `date_recur_modular_sierra` | Modular: Sierra | `DateRecurModularSierraWidget` | AJAX + modal, Google-Calendar-style; uses a `date_recur` interpreter. Settings: `interpreter`, `date_format_type` (default `medium`), `occurrences_modal` (default TRUE). Requires permission `date_recur_modular use sierra form`. |

Config schema for the settings lives in
`config/schema/date_recur_modular.schema.yml`
(`field.widget.settings.date_recur_modular_oscar`, `…_sierra`).

## Building your own widget (the framework)

The README is explicit: features are **not** added to these widgets — copy one into
your own module, give it a unique `@FieldWidget` id, and adapt it. Reusable pieces:

- `DateRecurModularWidgetBase` — base class (extends the date_recur widget base).
- `DateRecurModularWidgetFieldsTrait` — shared form field builders.
- `DateRecurModularWidgetOptions` — option lists (weekdays, frequencies, ordinals).
- `DateRecurModularUtilityTrait` — occurrence/RRULE helper methods.
- Sierra modal forms: `src/Form/DateRecurModularSierraModalForm.php`,
  `DateRecurModularSierraModalOccurrencesForm.php` (routes in
  `date_recur_modular_widget.routing.yml`).

Skeleton:

```php
namespace Drupal\my_module\Plugin\Field\FieldWidget;

use Drupal\date_recur_modular\Plugin\Field\FieldWidget\DateRecurModularWidgetBase;

/**
 * @FieldWidget(
 *   id = "my_recur_widget",
 *   label = @Translation("My recurrence widget"),
 *   field_types = { "date_recur" }
 * )
 */
class MyRecurWidget extends DateRecurModularWidgetBase {
  // Copy formElement()/massageFormValues() from Alpha and adapt.
}
```

Because the widgets may change between releases, pin the module version if you rely on
one directly.
