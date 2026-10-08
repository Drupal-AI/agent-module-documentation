# Events

Event name constants are on `Drupal\commerce_fedex\Event\CommerceFedExEvents`.

| Constant | Name | Event object | Fired from |
|---|---|---|---|
| `BEFORE_RATE_REQUEST` | `commerce_fedex.before_rate_request` | `RateRequestEvent` | `FedEx::getRateRequest()` just before the request is returned/sent |
| `BEFORE_PACK` | `commerce_fedex.before_pack` | `BeforePackEvent` | `CommerceFedExPacker::getOrderItems()` before order items are packed |

## `RateRequestEvent`

`src/Event/RateRequestEvent.php`. Lets you mutate the outgoing FedEx request.

- `getRateRequest(): CreateRatesRequest` / `setRateRequest(CreateRatesRequest)` — the
  `FedexRest\Services\Rates\CreateRatesRequest` about to be sent (shipper, recipient, line items,
  currency, rate types, etc.).
- `getShipment(): ShipmentInterface` / `setShipment(ShipmentInterface)`.

```php
public static function getSubscribedEvents() {
  return [\Drupal\commerce_fedex\Event\CommerceFedExEvents::BEFORE_RATE_REQUEST => 'onRateRequest'];
}

public function onRateRequest(\Drupal\commerce_fedex\Event\RateRequestEvent $event): void {
  $request = $event->getRateRequest();
  // e.g. add a surcharge, tweak addresses, force rate request types...
}
```

The module's own `commerce_fedex.rate_request_subscriber` (`RateRequestEventSubscriber`) subscribes
to this event: **in test mode only** (`!$rate_request->production_mode`) it strips item
descriptions/counts and reduces shipper/recipient to country + postal code, because the FedEx
sandbox only answers a narrow set of payloads.

## `BeforePackEvent`

`src/Event/BeforePackEvent.php`. Lets you change which order items get packed (e.g. exclude virtual
products, split by warehouse). Getters/setters: `getOrderItems()/setOrderItems()`,
`getOrder()/setOrder()`, `getShippingProfile()/setShippingProfile()`. (Marked with a `@todo` to be
folded into commerce_shipping upstream.)
