<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Features, config keys & the MauticFeature plugin system

Single config object: **`commerce_mautic_connect.settings`** (schema
`config/schema/commerce_mautic_connect.schema.yml`, defaults `config/install/…settings.yml`).
Every `enable_*` defaults to `false`.

## Config keys (all in `commerce_mautic_connect.settings`)

| Key | Default | Feature | Meaning |
|---|---|---|---|
| `enable_abandoned_cart` | `false` | Abandoned Cart | master toggle |
| `field_cart_html` | `commerce_cart_items_html` | Abandoned Cart | Mautic field alias for rendered cart HTML |
| `field_cart_updated` | `commerce_cart_updated` | Abandoned Cart | Mautic datetime alias (last-updated, ISO-8601) |
| `field_cart_language` | `commerce_cart_language` | Abandoned Cart | Mautic text alias for langcode (not in schema; written at runtime) |
| `enable_customer_metrics` | `false` | Customer Metrics | master toggle |
| `base_currency` | `''` | Customer Metrics | currency CLV/AOV are computed in |
| `field_total_spent` | `commerce_total_spent` | Customer Metrics | Monetary (CLV) |
| `field_total_orders` | `commerce_total_orders` | Customer Metrics | Frequency |
| `field_last_order_date` | `commerce_last_order_date` | Customer Metrics | Recency (Y-m-d) |
| `field_first_order_date` | `commerce_first_order_date` | Customer Metrics | Tenure (Y-m-d) |
| `field_average_order_value` | `commerce_aov` | Customer Metrics | AOV |
| `customer_metrics_order_states` | `[]` | Customer Metrics | which order states count (checkboxes) |
| `enable_coupon_tags` | `false` | Coupon Tags | master toggle |
| `coupon_tag_prefix` | `coupon:` | Coupon Tags | prepended to each coupon code as a Mautic tag |
| `enable_customer_details` | `false` | Customer Details | master toggle |
| `address_field` | `address` | Customer Details | billing-profile address field (first/last name + country) |
| `phone_field` | `field_telephone_number` | Customer Details | billing-profile phone field |
| `mautic_firstname_field` | `firstname` | Customer Details | Mautic target (native) |
| `mautic_lastname_field` | `lastname` | Customer Details | Mautic target (native) |
| `mautic_phone_field` | `phone` | Customer Details | Mautic target (native) |
| `mautic_country_field` | `country` | Customer Details | Mautic target (native); ISO code → country name |

## The four MauticFeature plugins (`src/Plugin/MauticFeature/`)

Each renders one settings tab and owns its own validate/submit. `abandoned_cart`
(w0), `coupon_tags` (w5), `customer_metrics` (w10), `customer_details` (w25).

- **AbandonedCart** — three field-alias textfields; an **operations** button
  "Create Abandoned Cart Fields in Mautic" (`createMauticField` × cart HTML/updated/
  language); a **Template Preview** UI (select a recent draft order + a theme, opens
  the preview route in a new tab). `validateForm` blocks enabling unless the aliases
  already exist in Mautic (`mauticFieldExists`).
- **CouponTags** — enable toggle + `coupon_tag_prefix` (regex-validated
  `^[A-Za-z0-9_\-:]+$`, maxlength 50). No Mautic fields to create (uses native tags).
- **CustomerMetrics** — enable toggle, `base_currency` select (from
  `commerce_currency` entities), five metric-field aliases, an order-states checkbox
  set (built from every order type's workflow states), and a "Create Customer Metrics
  Fields in Mautic" button. Shows a Commerce Exchanger present/absent note when >1
  currency exists. Injects `plugin.manager.workflow` on top of the base services.
- **CustomerDetails** — enable toggle, source fields (`address_field`, `phone_field`)
  and four Mautic target aliases (default to native `firstname`/`lastname`/`phone`/
  `country`). Nothing to create in Mautic; `validateForm` only checks the four target
  aliases exist before enabling.

## Field creation & validation (base class)

`MauticFeaturePluginBase` (`src/MauticFeaturePluginBase.php`) provides the shared
services (`mauticApi`, `loggerFactory`, `entityTypeManager`) and helpers:
- `createMauticField($alias,$label,$type)` — POSTs a `contactFields` create (group
  `core`, object `lead`, published); if it already exists, finds it by alias and
  `edit()`s it. Types used: `html`, `datetime`, `text`, `number`, `date`.
- `mauticFieldExists($alias)` — lists all contact fields and matches by alias.
  **Fails open**: returns `TRUE` when the Mautic API is unreachable so an admin isn't
  hard-blocked from enabling a feature during an outage.
- `flattenErrorArray()` — turns nested Mautic error arrays into a readable string.

## Extending: add your own MauticFeature

Create `src/Plugin/MauticFeature/MyThing.php` extending `MauticFeaturePluginBase`
with `#[MauticFeature(id: 'my_thing', label: new TranslatableMarkup('My Thing'),
weight: 30)]`, implement `buildForm/validateForm/submitForm`, group elements under
`'#group' => 'tabs'`, and store per-button plugin refs via `'#plugin_instance' => $this`
for static submit callbacks (Commerce pattern; avoids `\Drupal::service()`). Override
`create()` to inject extra services. Alter existing definitions with
`hook_mautic_feature_info_alter(array &$definitions)`.
