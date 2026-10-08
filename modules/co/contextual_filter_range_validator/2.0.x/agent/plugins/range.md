<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Range argument validator (`RangeArgumentValidator`)

Class: `Drupal\contextual_filter_range_validator\Plugin\views\argument_validator\RangeArgumentValidator`
(file `src/Plugin/views/argument_validator/RangeArgumentValidator.php`). Extends core
`Drupal\views\Plugin\views\argument_validator\ArgumentValidatorPluginBase`. Registered via annotation
`@ViewsArgumentValidator(id = "range", title = @Translation("Range"))`, so it appears as **Range** in the
Views contextual-filter "Validator" select list.

## Install / enable
1. `composer require drupal/contextual_filter_range_validator` (or download manually).
2. Enable the module (`drush en contextual_filter_range_validator` or `/admin/modules`). Only core `views` is required.

## Configure (all config lives in the View)
The module has no settings page and no config objects/schema of its own. Configure per contextual filter:
1. Edit a View → **Advanced → Contextual Filters → Add** (or edit an existing one).
2. Under **When the filter value IS available or a default is provided**, tick **Specify validation criteria**.
3. Set **Validator** to **Range**.
4. Two `#type => number` fields appear (`buildOptionsForm()`): **Minimum value** (`range_min`) and
   **Maximum value** (`range_max`). Both bounds are **inclusive**; leave either blank for an open-ended side.
5. Choose the **Action to take if filter value does not validate** (core option, e.g. hide view / 404).

`validateOptionsForm()` guards the settings: each entered bound must be `is_numeric`, and it errors if
`range_min > range_max`.

## Validation logic (`validateArgument(mixed $arg): bool`)
- Reads `range_min` / `range_max` from `$this->options`; a bound is treated as "set" when non-empty or the
  literal `'0'`, then cast with `(float)`.
- Returns `FALSE` immediately unless `is_numeric($arg)`; otherwise casts the argument to `(float) $val`.
- Returns `TRUE` when the value satisfies the configured side(s): both bounds (`$min <= $val <= $max`),
  min-only (`$val >= $min`), max-only (`$val <= $max`), or neither bound set (always valid). Anything else → `FALSE`.
- Bounds are inclusive. Non-numeric arguments always fail. See `tests/src/Unit/RangeArgumentValidatorTest.php`
  for the covered cases (e.g. `[0,1]` accepts 0 and 1, rejects -1 and 2; `'a'` rejected).

## Notes
- This validates the **format/range** of the incoming argument value; it is not an access-control check.
  Use core Views access/permissions for access.
- No routes, permissions, services, Drush commands, or libraries are provided. `hook_help()` in the
  `.module` only supplies the module's help-page text.
