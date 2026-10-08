# API — services & runtime architecture

All services are defined in `commerce_currency_resolver.services.yml`.

## Services

| Service | Class | Tag(s) | Purpose |
|---|---|---|---|
| `commerce_currency_resolver.manager` | `CurrencyResolverManager` | — | Helper: currency list, refresh decision, cookie name. |
| `commerce_currency_resolver.price_resolver` | `Resolver\CurrencyResolverPrice` | `commerce_price.price_resolver` (priority 1000) | Returns the `{prefix}{code}` per-currency price field. |
| `cache_context.currency_resolver` | `Cache\Context\CurrencyResolverCacheContext` | `cache.context` | Per-currency render caching (`currency_resolver`). |
| `commerce_currency_resolver.order_currency` | `EventSubscriber\CurrencyOrderSubscriber` | `event_subscriber` | On order load, refreshes a draft order whose currency no longer matches. |
| `commerce_currency_resolver.order_processor` | `CurrencyResolverOrderProcessor` | `commerce_order.order_processor` (priority 1000) | On order refresh, recalculates total when currency changed. **Removed** when the exchanger submodule is enabled (its `ExchangerOrderProcessor` replaces it via a ServiceProvider). |

## `CurrencyResolverManagerInterface`

```php
$m = \Drupal::service('commerce_currency_resolver.manager');
$m->getCurrencies();                 // ['EUR' => CurrencyInterface, ...] active only
$m->getCurrencyByCode('EUR');        // ?CurrencyInterface
$m->getCookieName();                 // Settings::get('commerce_currency_cookie') ?? 'commerce_currency'
$m->shouldCurrencyRefresh($order, $currency); // bool — the gate below
```

`shouldCurrencyRefresh()` returns TRUE only when: order state is `draft`, it has items, the
order's total currency differs from the current currency, the order is owned by the current
user, `$order->access('update')` passes, and the order is not locked. A
`currency_resolver_force_refresh` order-data flag forces TRUE; `currency_resolver_skip_refresh`
forces FALSE.

## Order-data flags (constants on the interface)

| Constant | Value | Effect |
|---|---|---|
| `CURRENCY_RESOLVER_FORCE_REFRESH` | `currency_resolver_force_refresh` | Force a refresh for this order (cleared after). |
| `CURRENCY_RESOLVER_SKIP_REFRESH` | `currency_resolver_skip_refresh` | Never refresh this order. |
| `CURRENCY_ORDER_REFRESH` | `currency_order_refresh` | Internal signal to submodule order processors (e.g. shipping) that a refresh happened. |
| `CURRENCY_RESOLVER_PRICE_FIELD` / `_AUTO` / `_COMBO` | `field` / `auto` / `combo` | `currency_source` values. |

```php
$order->setData('currency_resolver_force_refresh', TRUE)->save();
$order->setData('currency_resolver_skip_refresh', TRUE)->save();
```

## Resolve a price programmatically

When creating order items in code, resolve the price so the cart currency stays consistent:

```php
$context = new \Drupal\commerce\Context(\Drupal::currentUser(), $store);
$price = \Drupal::service('commerce_currency_resolver.price_resolver')
  ->resolve($product, 1, $context);
$order_item = $order_item_storage->createFromPurchasableEntity($product, ['unit_price' => $price]);
```

## Cache context

Add `currency_resolver` to `#cache['contexts']` of any block/render array whose output depends
on the resolved currency. Its value is the current currency code
(`CurrentCurrencyInterface::getCurrency()->getCurrencyCode()`).

## Current-currency chain (where submodules plug in)

The *current currency* itself is decided by Commerce's chain `commerce_price.currency_resolver`.
This module ships no currency resolver of its own (default = store currency); the submodules add
tagged `commerce_price.currency_resolver` services: **cookie** (1000), **geoip**/**smart_ip**
(900), **language** (800). First non-NULL wins.
