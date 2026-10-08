<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `human_decimal` field formatter

`Drupal\human_decimal\Plugin\Field\FieldFormatter\HumanDecimal`
(id `human_decimal`, label "Human decimal") — a subclass of core
`Drupal\Core\Field\Plugin\Field\FieldFormatter\DecimalFormatter`, applicable to core
**`decimal`** fields only.

## What it does

Renders a decimal value with **trailing zeros suppressed**: a value whose fractional part is all
zeros shows as an integer, and a value with fewer fractional digits than the configured scale
shows only those digits (no zero-padding). Values with more digits than the scale are still
**rounded**, exactly like the core formatter.

| Value | Scale | Output |
| --- | --- | --- |
| `5` | 2 | `5` |
| `0` | 2 | `0` |
| `-42` | 2 | `-42` |
| `1234567` | 2 | `1,234,567` |
| `5.5` | 2 | `5.5` |
| `9.1` | 4 | `9.1` |
| `5.55` | 2 | `5.55` |
| `5.555` | 2 | `5.56` (rounded) |
| `3.141` | 2 | `3.14` |
| `1234.5` | 2, `,` decimal / `.` thousand | `1.234,5` |

(from `tests/src/Unit/HumanDecimalFormatterTest.php`.)

## Settings

**Identical to the core Decimal formatter** — `defaultSettings()`, `settingsForm()` and
`settingsSummary()` are empty stubs that just return the parent's. So you get: `scale`,
`decimal_separator`, `thousand_separator`, and `prefix_suffix` (with the field's own prefix/suffix).
No settings are added or removed, and there is no config schema of its own (it reuses core's
`field.formatter.settings.number_decimal`).

## The logic (`HumanDecimal.php`, `numberFormat()`)

```php
protected function numberFormat($number) {
  $scale = $this->getSetting('scale');
  $digits = explode('.', $number + 0);          // '3.00' + 0 => 3 => ['3']; '3.20' => ['3','2']
  if (empty($digits[1])) {                       // no fractional part left after numeric coercion
    $scale = 0;
  }
  elseif (strlen($digits[1]) < $scale) {         // fewer real digits than scale
    $scale = strlen($digits[1]);                 // shrink scale, don't pad
  }
  return number_format($number, $scale, $this->getSetting('decimal_separator'), $this->getSetting('thousand_separator'));
}
```

The `$number + 0` coercion drops trailing zeros before the fractional part is measured; the
effective `$scale` is then lowered so `number_format()` prints only the digits that exist. When the
value has more fractional digits than the scale, `$scale` is left unchanged and `number_format()`
rounds normally.

## Usage

No code needed — enable the module, then on any entity with a **decimal** field go to
*Manage display* (or a View's field settings) and choose the **"Human decimal"** formatter. All the
standard Decimal formatter options appear underneath. Rendering (prefix/suffix handling, `#markup`
output, escaping) is inherited unchanged from core `NumericFormatterBase::viewElements()`.
