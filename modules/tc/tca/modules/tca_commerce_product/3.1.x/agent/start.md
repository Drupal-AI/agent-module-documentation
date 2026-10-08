# TCA commerce products (tca_commerce_product) — agent index

Adds TCA support for the **commerce_product** entity type. Requires parent `tca`, plus
`commerce_product` and the `entity` module. No config page, no own permissions/schema. Parent
mechanics: [../../../../3.1.x/agent/start.md](../../../../3.1.x/agent/start.md).

Key facts:
- Registers `TcaPlugin` id `tca_commerce_product`, `entityType: commerce_product`,
  `isFieldable() = TRUE` (`…/src/Plugin/TcaPlugin/Product.php`) → installs
  `tca_active`/`tca_public`/`tca_token` base fields on products.
- `hook_entity_type_alter()` replaces the `commerce_product` **access** handler with
  `TcaCommerceProductAccessControlHandler` (extends `\Drupal\entity\EntityAccessControlHandler`,
  injects `request_stack`) so token gating applies through Commerce's own access flow.
- Hides protected products from product search
  (`hook_query_search_commerce_product_search_alter`) and Views (`hook_views_query_alter`)
  for users without `tca bypass commerce_product`.
- Generates permissions `tca administer commerce_product` / `tca bypass commerce_product`
  (via the parent). No config of its own.
