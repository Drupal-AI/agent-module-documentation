# Setting up license-selling products

There is no single settings form — configuration is spread across Commerce entity types plus
the License admin. The `configure` route is `entity.commerce_license.collection`
(`/admin/commerce/licenses`, the list of issued licenses).

## Admin routes

| Route | Path | Purpose |
|---|---|---|
| `entity.commerce_license.collection` | `/admin/commerce/licenses` | List/manage issued licenses (add/edit/delete) |
| `entity.commerce_license.license_types` | `/admin/commerce/config/licenses/license-types` | List License type plugins; manage their fields |
| `commerce_license.configuration` | `/admin/commerce/config/licenses` | Licenses config menu |
| `commerce_license.dashboard` | `/admin/commerce/config/licenses/dashboard` | License status dashboard |

Licenses are fieldable per bundle (License type) via
`entity.commerce_license.field_ui_fields`.

## Wiring a product to sell a license (expiring license)

The chain (see README for the click path) is:

1. **Checkout flow** — "Login or continue as guest" pane must set *Guest checkout: Not
   allowed* (licenses need a real user). `/admin/commerce/config/checkout-flows`.
2. **Order type** — uses that checkout flow. `/admin/commerce/config/order-types`.
3. **Order item type** — enable the trait **"Provides an order item type for use with
   licenses"** (`commerce_license_order_item_type`). `/admin/commerce/config/order-item-types`.
4. **Product variation type** — enable the trait **"Provides a license"** (`commerce_license`),
   and set its order item type to the one above.
   `/admin/commerce/config/product-variation-types`.
5. **Product type** — uses that variation type.
6. **Product / variation** — on each variation, configure **License type** and **License
   expiration** (a License period plugin).

For **subscription-renewing** licenses, also enable the variation-type trait **"Allow
subscriptions"**, set the variation's *Subscription type = License*, expiration =
*Unlimited*, and choose a Billing schedule (requires `commerce_recurring`).

## The entity traits (what they store)

Enabling the `commerce_license` trait on a product variation type stores it in the variation
type's `traits` list and adds `license_type` + `license_expiration` fields to the variation.
Third-party settings on the variation type schema:

```
commerce_product.commerce_product_variation_type.*.third_party.commerce_license:
  license_types: []          # allowed License type plugin ids
  activate_on_place: bool     # activate the license when the order is placed
  allow_renewal: bool
  interval / period           # renewal window before expiration
```

## Lifecycle / workflow

Licenses use the `license_default` state-machine workflow (group `commerce_license`):

- **states**: `new`, `pending`, `active`, `renewal_in_progress`, `renewal_cancelled`,
  `suspended`, `expired`, `revoked`, `failed`, `canceled`.
- **transitions**: `activate` (new→pending), `confirm` (→active), `renewal_in_progress`,
  `cancel_renewal`, `suspend`, `expire`, `reactivate`, `revoke`, `fail`, `cancel`.

Event subscribers create/activate the license on order place/complete; `grantLicense()` /
`revokeLicense()` on the License type apply access on the relevant transitions. Expiry is
handled by cron (`Cron::run()` enqueues `commerce_license_expire` Advanced Queue jobs for
`active`/`renewal_in_progress` licenses whose `expires` ≤ now).

## Create a license programmatically

```php
$license = \Drupal::entityTypeManager()->getStorage('commerce_license')->create([
  'type' => 'role',                       // the License type plugin id (bundle)
  'state' => 'active',
  'uid' => $uid,
  'license_role' => 'premium_member',     // bundle field of the 'role' type
  'expiration_type' => ['target_plugin_id' => 'unlimited', 'target_plugin_configuration' => []],
]);
$license->save();
```
