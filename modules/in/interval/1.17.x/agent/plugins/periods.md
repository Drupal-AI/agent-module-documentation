<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Interval period plugins (`*.intervals.yml`)

Periods are **not hard-coded**. The manager `plugin.manager.interval.intervals`
(`IntervalPluginManager`) uses `YamlDiscovery('intervals', ...)`, so every module may ship
a `MODULE.intervals.yml` file whose top-level keys become period ids. Cache bin
`interval_plugins`; alter hook name `intervals`.

## Definition shape

Each entry supports these keys (defaults in `IntervalPluginManager::$defaults`):

| Key | Purpose | Default |
|---|---|---|
| `singular` | Singular label (translatable via `singular_context`) | `''` |
| `plural` | Plural label, shown in the widget dropdown (translatable via `plural_context`) | `''` |
| `php` | PHP `\DateTime::modify` unit: `seconds`, `minutes`, `hours`, `days`, `months`, or `years` | `hours` |
| `multiplier` | Multiplied by the entered count before applying (`week` = 7 × `days`) | `1` |
| `class` | Plugin class | `Drupal\interval\IntervalBase` |

## Built-in periods (`interval/interval.intervals.yml`)

| id | plural | php | multiplier |
|---|---|---|---|
| `second` | Seconds | seconds | 1 |
| `minute` | Minutes | minutes | 1 |
| `hour` | Hours | hours | 1 |
| `day` | Days | days | 1 |
| `month` | Months | months | 1 |
| `year` | Years | years | 1 |
| `week` | Weeks | days | 7 |
| `fortnight` | Fortnights | days | 14 |
| `quarter` | Quarters | months | 3 |

## Add your own

`mymodule.intervals.yml`:

```yaml
decade:
  singular: Decade
  plural: Decades
  php: years
  multiplier: 10
sprint:
  singular: Sprint
  plural: Sprints
  php: days
  multiplier: 14
```

Then `drush cr`. The new ids appear in the widget dropdown and in
`allowed_periods` options. `buildPHPString()` for `2` + `decade` yields `"20 years"`.

## Alter existing periods

```php
/** Implements hook_intervals_alter(). */
function mymodule_intervals_alter(array &$intervals) {
  $intervals['fortnight']['plural'] = t('Two weeks');
  unset($intervals['second']); // remove a period everywhere
}
```

Read definitions in code: `\Drupal::service('plugin.manager.interval.intervals')->getDefinitions()`.
