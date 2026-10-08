# Price resolution: services & events

## How a price list wins

Commerce resolves a purchasable entity's price by running a chain of `commerce_price.price_resolver`
services by priority. This module registers:

```yaml
commerce_pricelist.price_resolver:
  class: Drupal\commerce_pricelist\PriceListPriceResolver
  arguments: ['@commerce_pricelist.repository']
  tags:
    - { name: commerce_price.price_resolver, priority: 600 }
```

Priority **600** is higher than Commerce's default variation-price resolver, so a matching price
list item overrides the base price. `PriceListPriceResolver::resolve($entity, $quantity, $context)`
asks the repository for the best-matching item and returns its price:

- It reads `$context->getData('field_name', 'price')`. If `field_name` is `'list_price'` it returns
  the item's **list price**; otherwise it returns the item's **price**.
- Returns `NULL` when no price list matches, so lower-priority resolvers (the normal price) apply.

## Repository service

`commerce_pricelist.repository` (`PriceListRepositoryInterface`):

```php
$repo = \Drupal::service('commerce_pricelist.repository');
$item  = $repo->loadItem($purchasableEntity, $quantity, $context);   // best match or NULL
$items = $repo->loadItems($purchasableEntity, $context);             // all matching items
```

It matches on the enabled price lists whose conditions (store, customer, customer_roles, date
window) satisfy the `Context`, ordered by price-list `weight`, then picks the item for the
purchasable entity whose `quantity` threshold fits the requested quantity.

Manually resolve a price (as Commerce would):

```php
use Drupal\commerce\Context;
$context = new Context($account, $store);
$price = \Drupal::service('commerce_pricelist.price_resolver')
  ->resolve($variation, 1, $context); // Price object or NULL
```

## Lifecycle events

`Drupal\commerce_pricelist\Event\PriceListEvents` defines events for both entities, dispatched
with `PriceListEvent` / `PriceListItemEvent`. Each entity fires on: `LOAD`, `CREATE` (before
save), `PRESAVE`, `INSERT`, `UPDATE`, `PREDELETE`, `DELETE`. Constants:

- Price list: `PRICELIST_LOAD`, `PRICELIST_CREATE`, `PRICELIST_PRESAVE`, `PRICELIST_INSERT`,
  `PRICELIST_UPDATE`, `PRICELIST_PREDELETE`, `PRICELIST_DELETE`
  (values `commerce_pricelist.commerce_pricelist.<op>`).
- Price list item: `PRICELIST_ITEM_LOAD`, `PRICELIST_ITEM_CREATE`, `PRICELIST_ITEM_PRESAVE`,
  `PRICELIST_ITEM_INSERT`, `PRICELIST_ITEM_UPDATE`, `PRICELIST_ITEM_PREDELETE`,
  `PRICELIST_ITEM_DELETE` (values `commerce_pricelist.commerce_pricelist_item.<op>`).

Subscribe to e.g. `PriceListEvents::PRICELIST_ITEM_INSERT` to react when a new price is added.
