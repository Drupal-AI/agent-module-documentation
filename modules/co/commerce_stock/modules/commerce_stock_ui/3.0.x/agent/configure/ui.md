# Stock transaction UI

## The forms

| Route | Path | Class | Purpose |
|---|---|---|---|
| `commerce_stock_ui.stock_transactions1` | `/admin/commerce/config/stock/transactions1` | `StockTransactions1` | Step 1 — select the product variation. |
| `commerce_stock_ui.stock_transactions2` | `/admin/commerce/config/stock/transactions2` | `StockTransactions2` | Step 2 — enter and submit the stock transaction for that variation. |

Both require the permission **`use commerce stock transaction form`**. Menu entry: "Stock
transactions" under Commerce → Configuration → Stock
(`commerce_stock.configuration`). The forms transact against the resolved stock service, so
real persistence needs `commerce_stock_local`.

## Grant the permission

```php
$role = \Drupal\user\Entity\Role::load('warehouse_clerk');
$role->grantPermission('use commerce stock transaction form')->save();
```
```bash
drush role:perm:add warehouse_clerk 'use commerce stock transaction form'
```
This is deliberately separate from `administer commerce stock` so staff can enter stock
without changing stock settings.

## The link widget

Field widget id **`commerce_stock_level_transaction_form_link`** ("Link to stock transaction
form"), for `commerce_stock_level` fields (from `commerce_stock_field`). Instead of an inline
stock editor it renders a link to the transaction form. Select it on the variation type's
Manage form display:
```php
$fd = \Drupal::entityTypeManager()->getStorage('entity_form_display')
  ->load('commerce_product_variation.default.default');
$fd->setComponent('field_stock', ['type' => 'commerce_stock_level_transaction_form_link'])->save();
```

## Notes

- No config entities/objects are provided by this module — it is routes, a menu link, a
  permission and a widget.
- Read a role's permission: `drush cget user.role.<rid> permissions`.
