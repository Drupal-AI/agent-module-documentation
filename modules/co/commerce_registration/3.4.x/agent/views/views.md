# Views: manage-registrations listings & plugins

The Manage Registrations controller renders Views to list registrations for a product. Views ship as
optional config (`config/optional/views.view.*`) and the module provides supporting Views plugins.

## Shipped views (optional config)

| View | Used by |
|---|---|
| `manage_commerce_registrations` | Product with **multiple** registration-enabled variations — combined registration list (`block_1`). |
| `commerce_registrations` | Global admin registrations listing. |
| `commerce_order_registrations` | Embedded into the order display (`hook_preprocess_commerce_order`), arg = order id. |
| `product_registration_settings` | Settings tab when a product has multiple registration-enabled variations (per-variation edit links). |
| `product_registration_summary` | Per-product registration summary. |

When a product has a **single** registration-enabled variation, the controller instead reuses the
Registration module's `manage_registrations` view directly.

## Views plugins provided

| Type | id | Class | Role |
|---|---|---|---|
| `@ViewsArgumentDefault` | `commerce_registration_product_id` | `Plugin\views\argument_default\ProductId` | Extract product id from the URL. |
| `@ViewsFilter` | `commerce_registration_product_id` | `Plugin\views\filter\Product` | Filter by product (equality). |
| `@ViewsFilter` | `commerce_registration_product_variation` | `Plugin\views\filter\ProductVariation` | Filter by product variation (in-operator); schema key `default_to_first_variation`. |
| `@ViewsField` | `product_registration_settings_operations` | `Plugin\views\field\ProductSettingsOperations` | Operations column linking to per-variation settings. |
| `@ViewsArea` | `manage_commerce_registrations_caption` | `Plugin\views\area\ManageCommerceRegistrationsCaption` | Caption area. |
| `@ViewsArea` | `manage_commerce_registrations_empty` | `Plugin\views\area\ManageCommerceRegistrationsEmpty` | Empty-text area. |

Views data is declared in `commerce_registration.views.inc`; plugin config schema is in
`config/schema/commerce_registration.views.schema.yml`. The `commerce_registration.manager` service's
`getProductIdFromArgument()` resolves the product id from the `1+2+3` variation-id argument these views
use.
