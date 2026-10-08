<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Human Decimal Formatter (human_decimal) — agent index

A one-plugin module: a **field formatter** for core `decimal` fields that **suppresses trailing
zeros**. `3.00` → `3`; `3.23` → `3.23`; `5.5` (scale 2) → `5.5`; `5.555` (scale 2) → `5.56`
(still rounds). It extends core's `DecimalFormatter`, so it keeps all the standard Decimal
settings (scale, decimal separator, thousand separator, prefix/suffix) and forms — the only
change is a smaller effective scale when the value has no/fewer decimal digits.

There is **no config UI, no permissions, no routes, no config schema, no services, no drush, no
theming/templates**. You enable the module and select the formatter in a decimal field's
*Manage display*. So there is exactly one capability doc.

- **Use / understand the `human_decimal` field formatter (behaviour, settings, the
  `numberFormat()` logic)** → [fields/human_decimal.md](fields/human_decimal.md)

## Key facts (real machine names)

- Formatter plugin: id `human_decimal`, label "Human decimal", field types `{ decimal }`.
  Class `Drupal\human_decimal\Plugin\Field\FieldFormatter\HumanDecimal` extends core
  `Drupal\Core\Field\Plugin\Field\FieldFormatter\DecimalFormatter`.
- Overrides only `numberFormat()`; `defaultSettings()`/`settingsForm()`/`settingsSummary()` are
  empty stubs that defer to the parent (so settings = core Decimal formatter's).
- Depends on: `drupal:field`. Core: `^8 || ^9 || ^10 || ^11`. Package: `Field`. `configure`: none.
- Also implements `hook_help()` (renders README on `help.page.human_decimal`).
- No submodules. Unit test: `tests/src/Unit/HumanDecimalFormatterTest.php`.
