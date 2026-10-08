# Hook implementations (integrator-relevant)

All in `commerce_registration.module` unless noted. Cite these when extending the module.

| Hook | What it does |
|---|---|
| `hook_entity_base_field_info` | Adds `commerce_order_item.registration` (ref → registration, read-only, unlimited) and `registration.order_id` (ref → commerce_order, read-only). See [api/lifecycle.md](../api/lifecycle.md). |
| `hook_entity_type_alter` | Adds the `PreventProductTypeRegistrationField` constraint to `field_storage_config`; overrides the `registration` entity's `register` form class with `Form\RegisterForm`. |
| `hook_entity_access` | **Only tightens access.** Forbids `delete` of a registration that has a non-empty `order_id` and is not canceled ("Cannot delete a registration that is in use by an order."). For a `commerce_product` `manage registrations` operation, defers to the manage-registrations route access; if neutral, forbids ("The product has no variations configured for registration."). |
| `hook_entity_operation` | Adds a **Manage registrations** operation link to products where `access('manage registrations')` passes. |
| `hook_entity_insert` | For a new `RegistrationType`, auto-creates a `summary` view display showing only `mail` and `count` (skipped during config sync). |
| `hook_entity_delete` | Order deleted → nulls `order_id` on its registrations. Order **item** deleted (e.g. abandoned-cart / programmatic cart edits) → deletes its non-complete registrations. Complements `CartEventSubscriber`. Integrators can run their own `hook_ENTITY_TYPE_delete` first for different handling. |
| `hook_preprocess_commerce_order` | Embeds the `commerce_order_registrations` view (arg = order id) into the order display when the order has registrations. |
| `hook_theme` | Registers `commerce_order__admin` / `commerce_order__user` templates (order views that include registrations). |
| `hook_element_info_alter` | Prepends `Render\Element\Link::preRender` to the `link` element so product registration-settings links render. |
| `hook_form_commerce_order_item_add_to_cart_form_alter` | Saves any new per-variation registration settings and adds them as cacheable dependencies so the add-to-cart form rebuilds when settings change. |
| `hook_form_views_exposed_form_alter` | On the `manage_commerce_registrations` view, hides the `mail` filter when the product's total registration count is below `registration.settings:hide_filter`. |
| `hook_migration_plugins_alter` / `hook_migrate_source_info_alter` | Adds `order_id` to `d7_registration` migrations and swaps the source class to `Plugin\migrate\source\Registration`. |

## Event subscribers (services)

Not hooks, but the main runtime glue — see [api/lifecycle.md](../api/lifecycle.md):
`OrderSubscriber` (place→pending, paid→complete, cart-canceled→canceled), `CartEventSubscriber`
(item remove/reduce cleanup), `ProductEventSubscriber` (filter full/closed variations off add-to-cart
forms), `RegistrationEventSubscriber` (`REGISTRATION_ALTER_MAIL`: adds `commerce_product` and
`commerce_order` token entities to registration emails when a variation/order is in context).
