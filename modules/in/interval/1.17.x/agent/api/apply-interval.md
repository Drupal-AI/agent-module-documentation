<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Interval API — apply a span to a date, read values

The field item class `Drupal\interval\Plugin\Field\FieldType\IntervalItem` implements
`Drupal\interval\IntervalItemInterface`.

## Read a stored value

```php
$item = $node->get('field_x')->first(); // IntervalItem or NULL
$n      = $item->getInterval();   // int, e.g. 3
$period = $item->getPeriod();     // string id, e.g. 'week'
$def    = $item->getIntervalPlugin(); // period definition array (singular/plural/php/multiplier)
```

## Apply the interval to a \DateTime

`applyInterval(\DateTime $date, bool $limit = FALSE)` mutates `$date` **in place** by the
stored span. It builds a modify string via `buildPHPString()` (= count × `multiplier` + ` ` +
`php` unit) and calls `$date->modify(...)`. On failure it throws
`Drupal\interval\InvalidIntervalException` (which carries the offending `$date` and item).

```php
$date = new \DateTime('2024-01-31');
$item->applyInterval($date);          // e.g. field = 1 + month  ->  2024-03-02 (PHP overflow)
$item->applyInterval($date, TRUE);    // $limit=TRUE clamps month overflow to last day of prior month
echo $item->buildPHPString();         // "1 months"
```

The `$limit` guard only affects `php == 'months'`: if adding months pushed the day past the
month end, it re-modifies to `"last day of last month"` (so Jan 31 + 1 month → Feb 28/29).

## The `interval` form element

`Drupal\interval\Element\Interval` (`#type => 'interval'`) is a standalone `FormElement`
you can use outside a field. Sub-inputs: `interval` (number) and `period` (select). Props:

- `#default_value` => `['interval' => int, 'period' => string]`
- `#periods` => array of period ids to offer (default: all)
- `#theme` => `interval` (template `interval.html.twig`, wraps inputs in `container-inline`)

## Services & classes

| Thing | Id / class |
|---|---|
| Period plugin manager | `plugin.manager.interval.intervals` (`IntervalPluginManagerInterface`) |
| Field type | `interval` (`IntervalItem`) |
| Widget | `interval_default` (`IntervalWidget`) |
| Formatters | `interval_default`, `interval_php`, `interval_raw` |
| Base plugin class | `Drupal\interval\IntervalBase` |
| Exception | `Drupal\interval\InvalidIntervalException` |

Note `getValue()` / `setValue()` reset the cached period definition, so always re-read
`getIntervalPlugin()` after changing the value.
