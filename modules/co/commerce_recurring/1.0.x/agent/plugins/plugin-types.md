<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugin types

The module defines three plugin types (see `commerce_recurring.plugin_type.yml`). Each uses an
annotation, a manager service, and a `Plugin/Commerce/<Type>/` directory.

| Plugin type id | Manager service | Annotation | Directory | Shipped plugins |
|---|---|---|---|---|
| `commerce_billing_schedule` | `plugin.manager.commerce_billing_schedule` | `@CommerceBillingSchedule` | `Plugin/Commerce/BillingSchedule/` | `fixed`, `rolling` |
| `commerce_subscription_type` | `plugin.manager.commerce_subscription_type` | `@CommerceSubscriptionType` | `Plugin/Commerce/SubscriptionType/` | `product_variation`, `standalone` |
| `commerce_prorater` | `plugin.manager.commerce_prorater` | `@CommerceProrater` | `Plugin/Commerce/Prorater/` | `proportional`, `full_price` |

Subscription types are also **bundles** of the `commerce_subscription` entity
(`bundle_plugin_type = "commerce_subscription_type"`), so each subscription type id is a
subscription bundle.

## Billing schedule plugin

Extend `BillingScheduleBase` (or `IntervalBase` for interval-based ones like `fixed`/`rolling`).
Implements `BillingScheduleInterface`: `generateFirstBillingPeriod()`,
`generateNextBillingPeriod()`, `allowTrials()`, `generateTrialPeriod()`, plus the standard
`Configurable+PluginForm` config-form methods. Return `BillingPeriod` objects (`src/BillingPeriod.php`).

```php
#[/* annotation */]
/**
 * @CommerceBillingSchedule(
 *   id = "quarterly",
 *   label = @Translation("Quarterly"),
 * )
 */
class Quarterly extends IntervalBase { /* override generateNextBillingPeriod(), etc. */ }
```

## Subscription type plugin

Extend `SubscriptionTypeBase` implementing `SubscriptionTypeInterface`: `getPurchasableEntityTypeId()`,
`collectCharges(SubscriptionInterface, BillingPeriod)` (returns `Charge` objects),
`onSubscriptionActivate/Renew/…` lifecycle hooks, and `buildFieldDefinitions()` to add bundle
fields. `product_variation` binds to a variation; `standalone` has no purchasable entity.

## Prorater plugin

Extend `ProraterBase` implementing `ProraterInterface::prorateOrderItem($order_item, $start, $end)`
returning the adjusted `Price`. `proportional` scales by the fraction of the period; `full_price`
returns the price unchanged.

## Altering plugin definitions (hook)

The only invited hook is for proraters:

```php
function hook_commerce_prorater_info_alter(array &$plugins) {
  $plugins['proportional']['label'] = t('Better name');
}
```

(See `commerce_recurring.api.php`.) Billing schedule and subscription-type plugin definitions
are altered through the standard plugin-manager alter of their respective managers.
