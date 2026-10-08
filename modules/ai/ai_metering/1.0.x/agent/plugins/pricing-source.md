# Add a model-pricing source — PricingSource plugin

Per-model prices come from `PricingSource` plugins. Ship your own to price a private or
self-hosted model.

- Plugin namespace: `Plugin/PricingSource`
- **Annotation** (not attribute): `Drupal\ai_metering\Annotation\PricingSource`
- Interface: `Drupal\ai_metering\Plugin\PricingSource\PricingSourceInterface`
  (base class `PricingSourceBase`)
- Manager service: `plugin.manager.ai_metering.pricing_source`
- Bundled: `LiteLLMPricingSource`, `ModelsDotDevPricingSource`

```php
namespace Drupal\mymodule\Plugin\PricingSource;

use Drupal\ai_metering\Plugin\PricingSource\PricingSourceBase;

/**
 * @PricingSource(
 *   id = "my_prices",
 *   label = @Translation("My price list"),
 * )
 */
class MyPricingSource extends PricingSourceBase {
  public function getPricing(): array {
    // Return per-model input/output prices per 1M tokens, keyed by model id.
    return ['my-model' => ['input' => 1.00, 'output' => 3.00]];
  }
}
```

After adding it, select it in AI Metering settings and run `drush aim-sync`
(see [../drush/commands.md](../drush/commands.md)). Also available: custom Views filter
plugins in `Plugin/views/filter/` (`UsageModelFilter`, `UsagePeriodFilter`,
`UsageProviderFilter`) for the usage-log views.
