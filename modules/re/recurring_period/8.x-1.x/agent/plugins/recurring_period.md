<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# RecurringPeriod plugin type

A recurring-period plugin generates an infinite sequence of dates from a starting date, defining
successive contiguous periods (half-open ranges `[start, end)`). Periods are either **rolling**
(anchored to the given date, so the same config yields different periods for different start dates) or
**fixed** (anchored to the calendar, so different start dates converge on the same sequence).

## Plugin type wiring

| Aspect | Value |
| --- | --- |
| Type id | `recurring_period` |
| Discovery namespace | `Plugin/RecurringPeriod` (`src/Plugin/RecurringPeriod/`) |
| Manager service | `plugin.manager.recurring_period` |
| Manager class | `Drupal\recurring_period\RecurringPeriodManager` (extends `DefaultPluginManager`) |
| Plugin interface | `Drupal\recurring_period\Plugin\RecurringPeriod\RecurringPeriodInterface` |
| Base class | `Drupal\recurring_period\Plugin\RecurringPeriod\RecurringPeriodBase` |
| Annotation | `@RecurringPeriod` (`Drupal\recurring_period\Annotation\RecurringPeriod`) |
| Alter hook | `hook_recurring_period_info_alter` (alter id `recurring_period_info`) |
| Definition cache | cid `recurring_period_plugins` |

The annotation has three keys: `id` (string), `label` (`@Translation`), `description` (`@Translation`).

`recurring_period.plugin_type.yml` additionally registers the type with the contrib **Plugin**
(`drupal/plugin`) module using `plugin_manager_service_id: plugin.manager.recurring_period` and the
decorator `Drupal\plugin\PluginDefinition\ArrayPluginDefinitionDecorator`. The Plugin module is
optional — the plugin type works without it.

## Bundled plugins

| Plugin id | Class | Behaviour | Configuration keys |
| --- | --- | --- | --- |
| `rolling_interval` | `RollingInterval` | Rolling: end = start + interval. Every period is exactly one interval long. | `interval` = `['period' => <interval plugin id>, 'interval' => <int multiplier>]` |
| `fixed_reference_date_interval` | `FixedReferenceDateInterval` | Fixed/calendar-aligned: ends on the next occurrence of `reference_date` + N×interval. First period can be short. | `reference_date` (date string, `Y-m-d`), `interval` (same shape as above) |
| `unlimited` | `Unlimited` | No end date. `calculateStart()`/`calculateEnd()` both return `RecurringPeriodInterface::UNLIMITED` (`0`). | none |

The `interval` value uses the **interval** module: `period` is an interval plugin id (e.g. `month`,
`week`, `year`), and `interval` is an integer multiplier. Internally each plugin builds a
`\DateInterval` via `\DateInterval::createFromDateString($interval * $definition['multiplier'] . ' ' . $definition['php'])`,
resolving the definition through `plugin.manager.interval.intervals`.

### Fixed vs rolling example

Config `reference_date = 2017-01-01`, `interval = 1 year` on `fixed_reference_date_interval`:
periods always end on 1 Jan, regardless of start date —
`9 May 2017 → 1 Jan 2018 → 1 Jan 2019 → …`. The same config on `rolling_interval` would give
`9 May 2017 → 9 May 2018 → …`.

## Adding a new plugin

Create `src/Plugin/RecurringPeriod/MyPeriod.php` in your module, extend `RecurringPeriodBase`, and
annotate it:

```php
namespace Drupal\my_module\Plugin\RecurringPeriod;

use Drupal\recurring_period\Plugin\RecurringPeriod\RecurringPeriodBase;

/**
 * @RecurringPeriod(
 *   id = "my_period",
 *   label = @Translation("My period"),
 *   description = @Translation("..."),
 * )
 */
class MyPeriod extends RecurringPeriodBase {

  public function calculateEnd(\DateTimeImmutable $start) {
    // Return the end date of the period beginning at $start,
    // or RecurringPeriodInterface::UNLIMITED for no end.
    return $start->add(new \DateInterval('P1M'));
  }

}
```

`RecurringPeriodBase` supplies `getLabel()`/`getDescription()` (from the definition), the configuration
plumbing (`getConfiguration`/`setConfiguration`/`defaultConfiguration`, deep-merged), empty
`buildConfigurationForm`/`validate`/`submit`, `calculateDependencies()` (returns `[]`), and the
`getPeriodFromDate`/`getPeriodContainingDate`/`getNextPeriod` derivations. You normally only override
`calculateEnd()` (and `calculateStart()` for fixed periods), plus `buildConfigurationForm`/
`submitConfigurationForm` and `defaultConfiguration` if your plugin is configurable.

Minimum to implement: `calculateEnd()`. The deprecated `calculateDate()` is delegated to/from
`calculateEnd()` by the base class for back-compat, so implementing either works.

## Altering definitions

Implement `hook_recurring_period_info_alter(array &$definitions)` to modify or swap discovered plugin
definitions (e.g. override a bundled plugin's `class`).
