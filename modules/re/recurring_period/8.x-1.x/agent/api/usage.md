<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using a recurring-period plugin (calculation API)

Get a configured plugin instance from the manager, then ask it for dates or `Period` objects.

```php
/** @var \Drupal\recurring_period\RecurringPeriodManager $manager */
$manager = \Drupal::service('plugin.manager.recurring_period');

// Second arg is the plugin configuration.
$plugin = $manager->createInstance('rolling_interval', [
  'interval' => ['period' => 'month', 'interval' => 1],
]);

$start = new \DateTimeImmutable('2024-01-15T00:00:00', new \DateTimeZone('UTC'));
$period = $plugin->getPeriodFromDate($start);   // \Drupal\recurring_period\Datetime\Period
$next   = $plugin->getNextPeriod($period);       // period beginning at $period end
```

All date arguments and return values are `\DateTimeImmutable` (not `DrupalDateTime`).

## RecurringPeriodInterface methods

| Method | Returns | Meaning |
| --- | --- | --- |
| `calculateEnd(\DateTimeImmutable $start)` | `\DateTimeImmutable|int` | End date of the period beginning at `$start` (next date in the sequence), or `UNLIMITED` (`0`). Primary method to implement. |
| `calculateStart(\DateTimeImmutable $date)` | `\DateTimeImmutable|int` | Start of the period that contains `$date`. For rolling plugins it just returns `$date`; for fixed plugins it backdates to the aligned start. |
| `calculateDate(\DateTimeImmutable $start)` | `\DateTimeImmutable|int` | **Deprecated** — use `calculateEnd()`. Base class bridges the two. |
| `getPeriodFromDate(\DateTimeImmutable $start)` | `Period` | Period that **begins** at `$start` (`start`..`calculateEnd($start)`). |
| `getPeriodContainingDate(\DateTimeImmutable $date)` | `Period` | Period that **contains** `$date` (`calculateStart($date)`..`calculateEnd($date)`). For rolling plugins this equals `getPeriodFromDate()`. |
| `getNextPeriod(Period $period)` | `Period` | Next period; equals `getPeriodFromDate($period->getEndDate())`. Use it to iterate the sequence. |
| `getPeriodLabel(\DateTimeImmutable $start, \DateTimeImmutable $end)` | `TranslatableMarkup|string` | Generic human label; `rolling_interval` returns e.g. "1 month from <RSS date>". Base returns `''`. |
| `getLabel()` / `getDescription()` | `string` | From the plugin definition. |
| `const UNLIMITED = 0` | — | Sentinel returned by `calculateStart`/`calculateEnd` for periods with no end (e.g. `unlimited`). |

The interface also extends `ConfigurableInterface`, `DependentPluginInterface`, and
`PluginFormInterface`, so an instance carries `getConfiguration()`/`setConfiguration()`,
`calculateDependencies()`, and `buildConfigurationForm()`/`validateConfigurationForm()`/
`submitConfigurationForm()` — the latter three let a consuming module embed the plugin's own settings
form. Check for `UNLIMITED` before treating a return value as a date.

## The Period value object

`Drupal\recurring_period\Datetime\Period` — an immutable half-open range `[start, end)`.

```php
new Period(\DateTimeImmutable $start_date, \DateTimeImmutable $end_date, string $label = '');
```

| Method | Returns | Notes |
| --- | --- | --- |
| `getStartDate()` | `\DateTimeImmutable` | |
| `getEndDate()` | `\DateTimeImmutable` | Not included in the range. |
| `getLabel()` | `string` | |
| `getDuration()` | `int` | Seconds: `end.format('U') - start.format('U')`. |
| `contains(\DateTimeImmutable $date)` | `bool` | `TRUE` when `start <= $date < end` (compared as Unix timestamps). |
| `toEntity($entity_type_id, array $values = [])` | unsaved entity | See [entity-integration.md](entity-integration.md). |

## Instantiating from within a service

Inject the manager instead of using `\Drupal::service()`:

```yaml
my_module.foo:
  class: Drupal\my_module\Foo
  arguments: ['@plugin.manager.recurring_period']
```

Plugin classes extending `RecurringPeriodBase` are container-aware
(`ContainerFactoryPluginInterface`) and receive `plugin.manager.interval.intervals` automatically.
