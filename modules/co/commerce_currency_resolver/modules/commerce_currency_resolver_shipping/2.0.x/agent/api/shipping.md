# API — shipping integration

## Shipping-method class overrides

`commerce_currency_resolver_shipping.module` implements
`hook_commerce_shipping_method_info_alter()`:

```php
$definitions['flat_rate']['class']          = FlatRateCurrency::class;      // extends core FlatRate
$definitions['flat_rate_per_item']['class'] = FlatRatePerItemCurrency::class; // extends core FlatRatePerItem
```

So it does **not** add new plugin ids — the existing `flat_rate` / `flat_rate_per_item`
methods gain currency behaviour. Both classes are thin wrappers that use
`CurrencyResolverShippingTrait`.

## Rate calculation (`CurrencyResolverShippingTrait`)

- `calculateRates($shipment)` builds a `ShippingRate` for the order's currency via
  `getRatesAmount($orderCurrency)`; for `flat_rate_per_item` the price is multiplied by
  `$shipment->getTotalQuantity()`.
- `getRatesAmount($target)`:
  1. if `configuration['rate_amount']['currency_code'] === $target` → use it as-is;
  2. else if `configuration['fields'][$target]` has a number → use that per-currency amount;
  3. else auto-convert `rate_amount` with
     `commerce_currency_resolver_exchanger.calculator->priceConversion()`.
- `selectRate($shipment, $rate)`: if the rate currency differs from the order currency, convert
  both the amount and original amount to the order currency.

Constructor pulls `commerce_currency_resolver.manager`, `commerce_price.current_currency` and
`commerce_currency_resolver_exchanger.calculator` (hence the `commerce_exchanger` dependency).

## Order processor

`ShippingCurrencyOrderProcessor` (tag `commerce_order.order_processor`, **priority 999**):

```
if (!hasShipments($order)) return;
if (!$order->getData('currency_order_refresh')) return;   // set by the resolver's order processor
$order->unsetData('currency_order_refresh');
if (!$order->getData(ShippingOrderManagerInterface::FORCE_REFRESH))
  $order->setData(ShippingOrderManagerInterface::FORCE_REFRESH, TRUE);   // shipments recalc in new currency
```

Runs just below the resolver/exchanger order processors (1000) so it reacts to the
`currency_order_refresh` flag they set.
