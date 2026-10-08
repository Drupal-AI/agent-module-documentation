# Configure — bundles, order item types, displays

There is no single settings form. The `commerce_purchasable_entity.configuration` route
(`/admin/commerce/config/purchasable-entities`, permission `access commerce administration pages`)
is just a menu-landing page (core `SystemController::systemAdminMenuBlockPage`). Configuration is
per bundle + per display, all under Commerce admin.

## Admin locations

| Task | Path | Route |
|---|---|---|
| List purchasable entity **types** | `/admin/commerce/config/purchasable-entities/types` | `entity.commerce_purchasable_entity_type.collection` |
| Add a type | `/admin/commerce/config/purchasable-entities/types/add` | `entity.commerce_purchasable_entity_type.add_form` |
| Edit a type / manage fields | `/admin/commerce/config/purchasable-entities/types/manage/{type}` | `entity.commerce_purchasable_entity_type.edit_form` |
| Manage fields / form display / view display | `…/manage/{type}/fields`, `…/form-display`, `…/display` | Field UI |
| List purchasable **entities** | `/admin/commerce/purchasable-entities` | `entity.commerce_purchasable_entity.collection` |
| Add an entity | `/admin/commerce/purchasable-entities/entities/add` | `entity.commerce_purchasable_entity.add_page` |

## Create a purchasable entity type (bundle)

Form `Form\PurchasableEntityTypeForm` (`BundleEntityFormBase`). Fields: `label`, machine-name `id`
(max length `EntityTypeInterface::BUNDLE_MAX_LENGTH`), and — only when `commerce_order` is enabled —
`orderItemType`, a `select` whose options are the order item types whose
`getPurchasableEntityTypeId()` equals `commerce_purchasable_entity` (i.e. those that target this
entity type). `orderItemType` is required. Set it to the order item type used when the entity is
purchased (the module ships `purchasable_entity`).

Shipped defaults (`config/install` + `config/optional`):

- Bundle `default` (`commerce_purchasable_entity.commerce_purchasable_entity_type.default`) with
  `orderItemType: purchasable_entity`.
- Order item type `purchasable_entity` (`purchasableEntityType: commerce_purchasable_entity`,
  `orderType: default`) and its default form/view displays. These are `config/optional`, so they
  install only when `commerce_order` is present.

## Wiring into a storefront

1. `drush en commerce_purchasable_entity -y` (pulls in `commerce`, `commerce_price`,
   `commerce_store`).
2. Create/adjust a purchasable entity type and choose its order item type (or use the shipped
   `default` type + `purchasable_entity` order item type).
3. Add fields per bundle via Field UI if needed; adjust the form/view displays.
4. Create purchasable entities (each requires `sku`, `title`, `price`, and at least one `stores`
   reference).
5. Add them to orders via your own/alternative add-to-cart form — this module ships none (it targets
   sites using e.g. Commerce Webform Order or custom code). Commerce resolves the order item price
   from the entity server-side.
