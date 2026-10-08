# Alter hooks

Two alter hooks, both invoked from the service (`HoursMinutesSecondsService`). Implement in
`MYMODULE.module`; run `drush cr` after adding one.

## `hook_hour_minutes_seconds_factor_alter(array &$factor)`

Alters the unit → definition map returned by `factorMap()`. Each entry needs `factor value`
(seconds), `label single`, `label multiple`. Only add **fixed-length** units (the module stops at
weeks on purpose; months/years vary).

```php
function mymodule_hour_minutes_seconds_factor_alter(array &$factor) {
  $factor['f'] = [
    'factor value' => 1209600,      // a fortnight
    'label single' => 'fortnight',
    'label multiple' => 'fortnights',
  ];
}
```

This affects `secondsToFormatted()`, `toArray()`, the natural-language formatter, and the JS
`factorMap` passed to timers.

## `hook_hour_minutes_seconds_format_alter(array &$format)`

Alters the selectable format strings returned by `formatOptions()` (the keys shown in the widget and
formatter *Display format* dropdowns).

```php
function mymodule_hour_minutes_seconds_format_alter(array &$format) {
  $format['hh:mm'] = 'hh:mm';   // add
  unset($format['s']);          // or remove one
}
```

There is no `hours_minutes_seconds.api.php`; these two `->alter()` calls (in `factorMap()` and
`formatOptions()`) are the whole extension surface.
