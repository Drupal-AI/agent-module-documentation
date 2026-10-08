# Turn a node type into a Basket product

Basket does not define a product entity — **any node bundle** becomes a product once it is registered
in the `basket_node_types` table. Orders themselves are the installed `basket_order` node type.

## Steps

1. **Create a content type** (e.g. `goods`) and add fields:
   - an **image** field (core Image) for the product picture,
   - a **price** field of type **`basket_price_field`** (Basket's own currency-aware field — the cart
     only reads prices from this type; see [../fields/price-field.md](../fields/price-field.md)),
   - optionally a **stock** field (core Number/integer) for on-hand quantity.
2. **Register the bundle** at `/admin/basket/settings-node_types` (route
   `basket.admin.pages/settings-node_types`, perm `basket access_page node_types`, handler
   `Admin\Page\NodeTypes`). There you map, per bundle, which field is the **image**, which is the
   **price** (`basket_price_field`), which is the **stock**, the **add-to-cart button** text/behavior,
   whether an **extra-params form** is offered, and the `add_count_sum` toggle (adding an item already
   in the cart increments its quantity instead of resetting it — read in `BasketCart::add()`).
   These settings are serialized into the bundle's `extra_fields` column of `basket_node_types`.
3. **Manage stock/products** at `/admin/basket/stock-product` (`Admin\Page\StockProduct`) and
   create products from the Shop toolbar "Add a product" link (requires
   `create <bundle> content`).
4. **Expose the add-to-cart button** either on the node display
   (`/admin/structure/types/manage/<bundle>/display`, the "Basket add" extra field from
   `hook_entity_extra_field_info` → `BasketExtraFields`) or as a Views field (`basket_add`).

## What the cart then does with the bundle

- `BasketCart::getItemsInBasket()` / `getCount()` join `basket` → `node_field_data` and restrict to
  the registered bundles, published, default-langcode rows only.
- `BasketCart::getItemPrice()` resolves the price from the bundle's `basket_price_field` via
  `Query\BasketQuery::getNodePriceMin()`, converted to the current currency; `getItemImg()` resolves
  the first image fid. **Prices are always server-side** — the cart stores only nid/count/params.
- Deleting a product node cascades (`hook_entity_delete` → `Entity::delete()` clears its `basket`
  cart rows and order links).

## Helpful methods

```php
$basket = \Drupal::service('Basket');
$types  = $basket->getNodeTypes();                 // registered product bundles (objects)
$fields = $basket->getNodeTypeFields('goods', ['basket_price_field']); // pick price-field candidates
$price  = $basket->getNodePrice($node, 'MIN');     // computed price for a product node
```
