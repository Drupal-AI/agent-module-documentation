<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Purchasable Entity (commerce_purchasable_entity) — agent index

Defines a lightweight, bundleable **purchasable** content entity for Drupal Commerce as an
alternative to the product + variation pair. The content entity `commerce_purchasable_entity`
(base class `Drupal\commerce\Entity\CommerceContentEntityBase`) implements Commerce's
`Drupal\commerce\PurchasableEntityInterface`, so it carries the fields Commerce requires of a
sellable thing — `sku` (unique), `title`, `price` (a `commerce_price` field), and a required
`stores` reference to `commerce_store` — and can be the target of an order item type, flowing
through cart, checkout, pricing, tax and promotions like a product variation. Each purchasable
entity belongs to a bundle defined by the config entity `commerce_purchasable_entity_type`, whose
only extra setting is `orderItemType` (which order item type is used when the entity is added to an
order). See `src/Entity/PurchasableEntity.php` and `src/Entity/PurchasableEntityType.php`.

The module provides the full admin surface for these entities (list builders, entity forms, an
access-control handler, and a custom HTML route provider) plus a storage handler with a
`loadBySku()` helper. It deliberately ships **no** add-to-cart form of its own — it is meant for
sites with simple products and an alternative add-to-cart flow (e.g. Commerce Webform Order); the
unit price on the order item is resolved server-side from the entity's `price` field by Commerce,
never from request input. Prices and references are admin-managed entity data, not user input.

- Depends on: `commerce:commerce`, `commerce:commerce_price`, `commerce:commerce_store`
  (composer also requires `drupal/commerce:^2.19 || ^3.0`).
- Core: `^9 || ^10 || ^11`. Package: `Commerce (contrib)`.
- No dedicated settings form / info.yml `configure` route. There is a menu-landing route
  `commerce_purchasable_entity.configuration` (`/admin/commerce/config/purchasable-entities`, a core
  `SystemController::systemAdminMenuBlockPage`). All real configuration is per bundle / per
  form-and-view display via Field UI.
- Provides config schema (bundle config entity). Provides 5 permissions. **No** Drush, **no** hooks
  (no `.module`/`.install`), **no** `.services.yml`, **no** plugin types.

## What you'd do → where

- **Create/configure a purchasable entity type (bundle), wire it to an order item type, set up
  form/view displays, add fields** → [configure/setup.md](configure/setup.md)
- **The base fields (`sku`, `title`, `price`, `stores`, `uid`, `status`, …) and the order-item-type
  field mapping** → [fields/base-fields.md](fields/base-fields.md)
- **Create/load purchasable entities from code, the interface methods, `loadBySku()`, the routes,
  and how it plugs into Commerce (order items / add-to-cart / pricing)** →
  [api/entity.md](api/entity.md)
- **Who can view/create/edit/delete and the access matrix** →
  [permissions/permissions.md](permissions/permissions.md)

## Key facts (real machine names)

- Content entity type: `commerce_purchasable_entity` (base_table `commerce_purchasable_entity`,
  data_table `commerce_purchasable_entity_field_data`, translatable). Bundle/config entity type:
  `commerce_purchasable_entity_type` (config prefix `commerce_purchasable_entity_type`;
  config_export keys `id`, `label`, `uuid`, `orderItemType`).
- Handlers (declared in the `@ContentEntityType` annotation): `storage` =
  `PurchasableEntityStorage`, `access` = `PurchasableEntityAccessControlHandler`, `list_builder` =
  `PurchasableEntityListBuilder`, `views_data` = core `EntityViewsData`, forms add/edit =
  `Form\PurchasableEntityForm`, delete = core `ContentEntityDeleteForm`, route_provider html =
  `Routing\PurchasableEntityHtmlRouteProvider` (makes the canonical route = the edit form).
- Entity routes: `entity.commerce_purchasable_entity.{collection,add_page,add_form,canonical,edit_form,delete_form}`
  under `/admin/commerce/purchasable-entities/…`; type routes
  `entity.commerce_purchasable_entity_type.{collection,add_form,edit_form,delete_form}` under
  `/admin/commerce/config/purchasable-entities/types/…`. Field UI is enabled
  (`field_ui_base_route = entity.commerce_purchasable_entity_type.edit_form`).
- Custom route: `commerce_purchasable_entity.configuration`
  (`/admin/commerce/config/purchasable-entities`, `_permission: 'access commerce administration
  pages'`).
- Permissions: `administer commerce_purchasable_entity_type` (restrict access = TRUE; also the
  entity `admin_permission`), `create commerce_purchasable_entity`,
  `edit commerce_purchasable_entity`, `delete commerce_purchasable_entity`,
  `view commerce_purchasable_entity`.
- Storage API: `PurchasableEntityStorage::loadBySku($sku)` (interface
  `PurchasableEntityStorageInterface`). Interface `Entity\PurchasableEntityInterface` adds
  `getTitle/setTitle`, `getSku/setSku`, `getPrice/setPrice`, `getCreatedTime/setCreatedTime`, plus
  `getStores/getStoreIds/setStores/setStoreIds` (from `EntityStoresInterface`) and
  `getOrderItemTypeId/getOrderItemTitle` (from Commerce's `PurchasableEntityInterface`).
- Base fields: `sku` (string, required, `UniqueField` constraint), `title` (string, required,
  translatable), `price` (`commerce_price`, required), `stores` (entity_reference →
  `commerce_store`, required, unlimited cardinality), `uid` (owner), `status` (published),
  `created`, `changed`.
- Shipped config: install `commerce_purchasable_entity.commerce_purchasable_entity_type.default`
  (bundle `default`, `orderItemType: purchasable_entity`); optional order item type
  `purchasable_entity` (`purchasableEntityType: commerce_purchasable_entity`, `orderType: default`)
  and its default form/view displays. Config schema:
  `config/schema/commerce_purchasable_entity.entity_type.schema.yml`.
