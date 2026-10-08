# Alter the USPS rate request (event) & services

## The before_rate_request event

Before the module sends a rate request to USPS you can alter it via a Symfony event.

- Event name: `USPSEvents::BEFORE_RATE_REQUEST` = `'commerce_usps.before_rate_request'`
  (`Drupal\commerce_usps\Event\USPSEvents`).
- Event object: `Drupal\commerce_usps\Event\USPSRateRequestEvent` — carries the request data and
  the shipment/context so a subscriber can adjust dimensions, weight, package selection or other
  request parameters before it is dispatched.

Subscribe to it like any event:

```php
// my_module.services.yml
services:
  my_module.usps_subscriber:
    class: Drupal\my_module\EventSubscriber\UspsSubscriber
    tags: [{ name: event_subscriber }]
```

```php
use Drupal\commerce_usps\Event\USPSEvents;
use Drupal\commerce_usps\Event\USPSRateRequestEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class UspsSubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [USPSEvents::BEFORE_RATE_REQUEST => 'onBeforeRateRequest'];
  }
  public function onBeforeRateRequest(USPSRateRequestEvent $event): void {
    // Inspect / modify the outgoing request here.
  }
}
```

## Services you can call

- `commerce_usps.usps_rate_request` (`USPSRateRequest`) — builds the request from the order's
  packages + ship-to address and returns the shipping rates; the injected pieces are the SDK
  factory, `commerce_price.rounder`, and the module logger.
- `commerce_usps.usps_sdk` (`USPSSdk`) / `commerce_usps.usps_sdk_factory` (`USPSSdkFactory`) — the
  low-level USPS API client (handles the OAuth token via `keyvalue.expirable` and the HTTP client).
- `commerce_usps.logger` — the `commerce_usps` logger channel used when request/response logging
  is enabled in the method's `options.log`.

## Choosing which services are rated

Each plugin advertises a fixed set of USPS services (see the `services` list on `USPSDomestic`
and `USPSInternational`). The shipping-method form lets an admin enable/disable individual
services; the plugin also exposes `getMailClass()`, `getFacilityTypeOptions()` and
`getRateIndicatorOptions()` (domestic vs international differ) that drive contract-pricing
requests.
