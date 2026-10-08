# Commerce Pricelist — agent index

Defines per-store / per-customer / per-quantity / date-ranged **price lists** for Drupal Commerce
and injects the matching price through a high-priority Commerce price resolver. Two content
entities: `commerce_pricelist` (Price list) and `commerce_pricelist_item` ("price"). Requires
`commerce`, `commerce_store`, `commerce_price`. Single permission `administer commerce_pricelist`.
No Drush, no configure route (managed under *Commerce → Price lists*).

- **The data model (both entities, their fields/conditions), admin paths, CSV import/export, creating them in code** →
  [configure/entities.md](configure/entities.md)
- **How prices are resolved: the price resolver, the repository service, and lifecycle events** →
  [api/services-events.md](api/services-events.md)

Key facts:
- `commerce_pricelist` fields: `name`, `stores`, `customers`, `customer_roles`, `start_date`,
  `end_date`, `weight`, `status`. Bundled per purchasable entity type (default
  `commerce_product_variation`).
- `commerce_pricelist_item` fields: `price_list_id`, `purchasable_entity`, `quantity`,
  `price`, `list_price`, `status`.
- Resolver `commerce_pricelist.price_resolver` (`PriceListPriceResolver`) is tagged
  `commerce_price.price_resolver` at **priority 600**; it overrides the base price when a list matches.
- Admin: `/admin/commerce/price-lists` (collection), `/price-list/add`, per-list "prices"
  collection with add/import/export.
