<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How `date_filter` takes over the core filters, and how to extend it

## The whole mechanism (`date_filter.module`)

```php
function date_filter_views_plugins_filter_alter(array &$plugins): void {
  if (\array_key_exists('date', $plugins))     { $plugins['date']['class']     = DateTimestamp::class; }
  if (\array_key_exists('datetime', $plugins)) { $plugins['datetime']['class'] = DateTime::class; }
}
```

Plugin **IDs stay `date` and `datetime`** — only the implementing class changes. Nothing in
views config records that `date_filter` is involved (except the `type` option value the UI
writes). Uninstalling the module silently reverts every view to core's handlers; a stored
`type: datetime` then becomes meaningless to core (core reads `value.type`).

## Class hierarchy

```
Drupal\views\Plugin\views\filter\NumericFilter
└── Drupal\date_filter\Plugin\views\filter\DateBase      (abstract)
    ├── DateTimestamp   (final)  → plugin id "date"     → value = UNIX timestamp
    └── DateTime        (final)  → plugin id "datetime" → value = storage-formatted string
```

`DateBase` members worth knowing:

| Member | Purpose |
|---|---|
| `$noTime` (bool) | the underlying field is date-only, so time UI is impossible |
| `$skipTimeUi` (bool) | render date input only (true) or date + time (false) |
| `$dataType` (string) | date vs timestamp marker |
| `$valueElements` | `['value' => NULL, 'min' => t('from'), 'max' => t('to')]` — the from/to relabel |
| `operators()` | parent's minus `regular_expression` |
| `defineOptions()` | adds `type` (default `date`); unsets `expose.placeholder`, `expose.min_placeholder`, `expose.max_placeholder` |
| `buildOptionsForm()` | adds the *Filter type* radios (`date` / `datetime`), disabled when `$noTime` |
| `buildExposeForm()` | removes the three placeholder settings |
| `validateOptionsForm()` | `strtotime()`-validates required exposed defaults → *"Invalid date format."* |
| `valueForm()` | admin: text boxes + offset hint. exposed: `#type => 'date'` (+ `time`, `step => 1`) elements, seeded from `getDate()` |
| `acceptExposedInput()` | normalises `['date' => …]` input, passes when at least one of min/max has a date |
| `opBetween()` / `opSimple()` | override `NumericFilter` so dates are not treated as integers |
| `getProcessedDate()` / `getDate()` | string or `['date' => …, 'time' => …]` → `DrupalDateTime` |
| `resetTimes()` | whole-day padding, see [../api/date-semantics.md](../api/date-semantics.md) |
| `processValue()` *(abstract)* | value → SQL-ready expression |
| `getInputTimezone()` *(abstract)* | which timezone user input is parsed in |

`DateTime` additionally uses `FieldAPIHandlerTrait`, copies `definition['entity field']` into
`definition['field_name']` so base fields work, and sets `$noTime = TRUE` when the field
storage's `datetime_type` is `DateTimeItem::DATETIME_TYPE_DATE`.

## Conflict: last `hook_views_plugins_filter_alter()` wins

Several contrib modules rewrite the same two plugin definitions (`views_year_filter`,
`smart_date`, …). Alter hooks run in module-weight then alphabetical order, so a module sorting
after `date_filter` overwrites `class` and `date_filter` becomes inert. Check what is actually
live:

```bash
drush php:eval '
  $m = \Drupal::service("plugin.manager.views.filter");
  foreach (["date", "datetime"] as $id) {
    print $id . " => " . $m->getDefinition($id)["class"] . "\n";
  }
'
```

If the answer is not `Drupal\date_filter\Plugin\views\filter\DateTimestamp` /
`…\DateTime`, another module won. Fixes, in order of preference: uninstall the competing
module, give `date_filter` a heavier module weight in `system.module` so its hook runs last, or
re-assert the classes from your own module (below).

## Extending

**Re-assert or replace the classes from a custom module** (`mymodule.module`):

```php
use Drupal\date_filter\Plugin\views\filter\DateTime as DateFilterDateTime;

/**
 * Implements hook_views_plugins_filter_alter().
 */
function mymodule_views_plugins_filter_alter(array &$plugins): void {
  // Runs after date_filter if 'mymodule' sorts later or has a heavier weight.
  $plugins['datetime']['class'] = MyDateTime::class; // extends DateFilterDateTime
}
```

**Subclass `DateBase`** to add behaviour (e.g. preset ranges) — implement the two abstract
methods:

```php
namespace Drupal\mymodule\Plugin\views\filter;

use Drupal\date_filter\Plugin\views\filter\DateBase;

class MyRangeFilter extends DateBase {

  protected function processValue($value, string $value_key = ''): ?string {
    $date = $this->getProcessedDate($value, $value_key);
    return $date === NULL ? NULL : $date->format('U');
  }

  protected function getInputTimezone(): string {
    return \date_default_timezone_get();
  }

}
```

`DateTimestamp` and `DateTime` are `final`, so extend `DateBase` (or copy their bodies), not
them.

**Add options** by overriding `defineOptions()` / `buildOptionsForm()` in your subclass, and add
matching keys to `views.filter.date` schema in your own `config/schema/*.views.schema.yml`.
