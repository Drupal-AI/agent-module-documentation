<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Best Rate — agent index

Adds a Drupal Commerce shipping method plugin, **`best_rate`**, that collapses several configured
shipping services into a single checkout option priced at the **cheapest** of them. The lowest amount is
chosen **server-side** from the rates that the source shipping methods computed; the customer sees one
line under an admin-configured label. Version **1.1.2**. Core `^10.2 || ^11`. Depends on
`commerce_shipping` (`^2.5 || ^3`). Package "Commerce (shipping)".

Two pieces of code, no routes/controllers/permissions/hooks/Drush:
- **`src/Plugin/Commerce/ShippingMethod/BestRate.php`** — the `best_rate` `@CommerceShippingMethod`
  plugin (extends `ShippingMethodBase`). Its config form and a placeholder rate.
- **`src/EventSubscriber/ShippingRatesSubscriber.php`** — subscribes to
  `ShippingEvents::SHIPPING_RATES` and does the actual grouping/lowest-price selection.
- **`.services.yml`** — registers the subscriber with `@current_user` + `@entity_type.manager`.

## How it works (end to end)

Commerce Shipping calculates rates per shipping method and dispatches a `ShippingRatesEvent` for each.
The best-rate feature is split across the plugin and the subscriber:

1. **`BestRate::calculateRates()`** always returns exactly one placeholder `ShippingRate`: service
   `default`, `amount` = **`new Price('0.00', 'USD')`**, description from config. It does *not* compute
   the price itself — the subscriber fills it in.
2. **`ShippingRatesSubscriber::filterBestRate()`** runs on every `SHIPPING_RATES` event and uses
   `drupal_static` to accumulate state across the per-method dispatches of one recalculation:
   - On first call it loads all enabled `best_rate` methods and, per method, records the configured
     rate-id group (`getServicesGroup()`), whether the current user is **excluded** (their roles
     intersect the method's `excluded_roles`), and whether the best rate should still **display**.
   - For a **non-best_rate** method: for each rate whose id is in a best-rate group it **saves the rate**
     to a static `saved_rates` bucket keyed by the best-rate method, and (unless the user is excluded)
     **removes it** from the displayed rates so the raw service no longer shows.
   - For a **best_rate** method: if rates were saved for it, it iterates them and keeps the one with the
     **lowest `getAmount()`** (`Price::lessThan`). Then either replaces the placeholder with that real
     `ShippingRate` (when `reference_real_rate` is on — the original label/description survive and the
     real rate is what gets saved to the shipment) **or** overrides only the placeholder's amount via
     `setOriginalAmount()` + `setAmount()` (keeping the configured label). If **no** rates were saved for
     it (nothing matched, or ordering was wrong), the best-rate rate is **removed entirely** — the
     `$0.00` placeholder never reaches checkout.

### Rate id format (the join key)
A source service is identified in `services_group` as **`{shipping_method_id}--{service_id}`**. The
config form builds these options from every enabled non-`best_rate` shipping method's services; the
subscriber matches them against `ShippingRate::getId()`. Rate selection is over server-resolved rates
only — no client-supplied amount or method id participates.

## Configuration (plugin config keys)

Set on the shipping method's plugin form (standard Commerce shipping-method admin UI, at
`/admin/commerce/shipping-methods`), stored in the shipping method config entity:

| Key | Type | Meaning |
| --- | --- | --- |
| `rate_label` | string, **required** | Label shown to the customer for the grouped option; also the `default` service label. |
| `rate_description` | string | Extra detail shown to the customer. |
| `reference_real_rate` | bool | Show the winning rate's own label/description instead of the configured ones, and save that real rate to the shipment. |
| `services_group` | list, **required** | The `{method}--{service}` rate ids to group/compare. |
| `excluded_roles` | list | Roles that see the raw grouped services instead of the best rate. |
| `excluded_roles_display` | bool | For excluded roles, show **both** the best rate and the raw rates. |
| `services` | `['default']` | Fixed single service for this method. |

Accessors on the plugin: `getServicesGroup()`, `getExcludedRoles()`, `getExcludedRolesDisplay()`.

## Role behaviour

`excluded_roles` lets chosen roles (e.g. "Sales") bypass grouping. If the current user has any excluded
role, the source rates are **not** removed. With `excluded_roles_display` on, an excluded user sees the
best-rate line **and** the individual rates; off, they see only the individual rates.

## Ordering caveat (important, from README + code)

Because the subscriber accumulates source rates into `saved_rates` as methods are processed, each
`best_rate` method must be ordered **after** the shipping methods whose services it groups. Placed first,
its `saved_rates` bucket is empty when its event fires, so the best-rate option is dropped and the source
services (already earmarked for removal) also disappear.

## Notes for callers
- No custom routes, controllers, AJAX endpoints, permissions, hooks, or Drush commands. Configuration is
  the normal shipping-method plugin form, gated by Commerce Shipping's admin permission.
- The placeholder currency literal is `USD`, but it is only a seed — the first saved rate replaces it
  before any comparison, so grouped rates use their own currency. (Comparing rates of different
  currencies would raise a `Price` currency-mismatch error at calculation time.)
- `rate_label` / `rate_description` are admin-entered config values rendered through Commerce's normal
  shipping-option rendering.
