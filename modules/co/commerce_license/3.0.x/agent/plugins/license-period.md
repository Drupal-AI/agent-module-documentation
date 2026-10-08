# License period plugins (CommerceLicensePeriod)

A **License period** decides *when a license expires*. It is the value of the variation's
"License expiration" and of the license's required `expiration_type` field
(`commerce_plugin_item:commerce_license_period`).

- Manager service: `plugin.manager.commerce_license_period`
  (`\Drupal\commerce_license\LicensePeriodManager`).
- Directory: `src/Plugin/Commerce/LicensePeriod/`. Annotation: `@CommerceLicensePeriod`.
  Interface: `LicensePeriodInterface`. Base: `LicensePeriodBase`.

## Built-in periods

| id | Class | Behavior |
|---|---|---|
| `unlimited` | `Unlimited` | Never expires (perpetual access) |
| `rolling_interval` | `RollingInterval` | Expires a configured interval (from `interval` module) after the start — e.g. 30 days / 1 year after activation |
| `fixed_reference_date_interval` | `FixedReferenceDateInterval` | Expires at intervals anchored to a fixed reference date (e.g. always the 1st of the month/year) |

`calculateEnd()` on the plugin returns the expiration timestamp stored in the license's
`expires` field; cron then expires licenses past it.

## Setting it on a license

```php
'expiration_type' => [
  'target_plugin_id' => 'rolling_interval',
  'target_plugin_configuration' => [
    'interval' => ['interval' => '1', 'period' => 'month'],
  ],
],
```

For `unlimited` the configuration is empty. The `expires` field stays empty for unlimited and
is set from `calculateEnd()` for the interval periods.

## Implement one

```php
/**
 * @CommerceLicensePeriod(
 *   id = "until_next_sunday",
 *   label = @Translation("Until next Sunday"),
 * )
 */
class UntilNextSunday extends LicensePeriodBase {
  public function calculateStart(LicenseInterface $license): DrupalDateTime { /* ... */ }
  public function calculateEnd(LicenseInterface $license): DrupalDateTime { /* ... */ }
  public function getLabel(): string { return (string) $this->t('Until next Sunday'); }
}
```

Alter the available periods with `hook_commerce_license_period_info_alter()`.
