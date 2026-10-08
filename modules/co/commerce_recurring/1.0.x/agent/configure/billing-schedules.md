<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure billing schedules

A **billing schedule** is the reusable definition of *when and how* a subscription is billed.
It is a `commerce_billing_schedule` **config entity** (config prefix
`commerce_recurring.commerce_billing_schedule.<id>`). Admin UI:
`/admin/commerce/config/billing-schedules` (add form `…/add`). Permission:
`administer commerce_billing_schedule`.

## Config entity fields (exported keys)

| Key | Meaning | Default |
|---|---|---|
| `id`, `label` | machine id + admin label | — |
| `displayLabel` | label shown to customers | — |
| `billingType` | `prepaid` (charge for the coming period) or `postpaid` (charge for the elapsed period) | `prepaid` |
| `combineSubscriptions` | combine subscriptions sharing a cycle into one recurring order | `false` |
| `retrySchedule` | dunning: days after failure to retry payment (sequence of ints) | `[1, 3, 5]` |
| `unpaidSubscriptionState` | subscription state applied once retries are exhausted | `canceled` |
| `plugin` | billing schedule plugin id: `fixed` or `rolling` | — |
| `configuration` | that plugin's settings (see below) | — |
| `prorater` | prorater plugin id: `proportional` or `full_price` | — |
| `proraterConfiguration` | that prorater's settings | `[]` |
| `status` | enabled/disabled | — |

## Schedule plugins and their `configuration`

Both plugins extend an interval base and share:

```yaml
configuration:
  interval:
    number: 1
    unit: month        # day | week | month | year
  trial_interval: {}   # empty = no trial; else { number: N, unit: <unit> }
```

- **`rolling`** — the interval is counted from each subscription's own start date. `configuration`
  is just `interval` + `trial_interval`.
- **`fixed`** — the interval is aligned to a calendar anchor. Adds two keys:
  ```yaml
  start_month: 1   # used only when interval unit is 'year'
  start_day: 1     # used when interval unit is 'month' or 'year'
  ```
  (For a monthly fixed schedule, `start_day` sets the day-of-month everyone is billed on.)

Trials: setting a non-empty `trial_interval` means new subscriptions begin in the `trial`
state; `allowTrials()` is true when `trial_interval` is non-empty.

## Prorater plugins

- **`proportional`** — charges a partial period pro rata (e.g. half a month = half price).
- **`full_price`** — id `full_price`, label "None (always charge the full price)"; never prorates.

## Create one with drush php:eval

```php
use Drupal\commerce_recurring\Entity\BillingSchedule;
BillingSchedule::create([
  'id' => 'monthly',
  'label' => 'Monthly',
  'displayLabel' => 'Monthly',
  'billingType' => 'prepaid',                 // or 'postpaid'
  'plugin' => 'rolling',                       // or 'fixed'
  'configuration' => [
    'interval' => ['number' => 1, 'unit' => 'month'],
    'trial_interval' => [],                    // ['number' => 14, 'unit' => 'day'] for a trial
  ],
  'prorater' => 'proportional',                // or 'full_price'
  'proraterConfiguration' => [],
  // Optional overrides:
  'retrySchedule' => [1, 3, 5],
  'unpaidSubscriptionState' => 'canceled',     // or 'expired'
  'combineSubscriptions' => FALSE,
])->save();
```

Read it back:

```bash
drush cget commerce_recurring.commerce_billing_schedule.monthly
```

Or in PHP: `BillingSchedule::load('monthly')->getPlugin()->getPluginId()`,
`->getBillingType()`, `->getRetrySchedule()`, `->getUnpaidSubscriptionState()`.

## Wiring subscriptions to a product

To sell a recurring product, its **product variation type** must enable the subscription
entity trait and choose a subscription type + billing schedule (via the variation-type form,
altered by `commerce_recurring_form_commerce_product_variation_type_form_alter()`). Purchases
then use the `recurring` order type and a `recurring_product_variation` order item type.
