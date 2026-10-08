<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# PayPal REST SDK & request events

commerce_paypal wraps PayPal's REST APIs in an SDK layer and dispatches events so you can
alter the payload sent to PayPal. You rarely need this for a normal store (the gateway
plugins call it for you) — reach for it when integrating custom flows.

## The Checkout SDK

`commerce_paypal.checkout_sdk_factory` (`CheckoutSdkFactoryInterface`) builds a
`CheckoutSdkInterface` from a gateway's configuration array:

```php
$factory = \Drupal::service('commerce_paypal.checkout_sdk_factory');
// $config is the gateway'"'"'s configuration array (must include mode + client_id + secret):
$sdk = $factory->get($config);
$token = $sdk->getAccessToken();     // OAuth2 token from PayPal (needs live creds + network)
```

`SdkInterface` (implemented by `SdkBase`, `CheckoutSdk`) exposes the REST operations:

| Method | Purpose |
|---|---|
| `getAccessToken()` / `getClientToken()` | OAuth2 / client token |
| `createOrder(OrderInterface $order, ?AddressInterface $billing = NULL)` | create a PayPal order |
| `getOrder($remote_id)` | fetch an order |
| `updateOrder($remote_id, OrderInterface $order)` | patch an order |
| `authorizeOrder($remote_id)` / `captureOrder($remote_id)` | authorize / capture |
| `capturePayment($auth_id, $params)` / `reAuthorizePayment(...)` | capture / re-auth an authorization |
| `refundPayment($capture_id, $params)` / `voidPayment($auth_id)` | refund / void |
| `verifyWebhookSignature(array $params)` | validate an incoming PayPal webhook |

The Fastlane equivalent is `commerce_paypal.fastlane_sdk` / `…fastlane_sdk_factory`
(`FastlaneSdkInterface`). Other services: `commerce_paypal.ipn_handler` (legacy IPN
validation), `commerce_paypal.smart_payment_buttons_builder`,
`commerce_paypal.custom_card_fields_builder`.

## Altering the request — events

Constants live in `Drupal\commerce_paypal\Event\PayPalEvents`. Subscribe to modify the data
before it goes to PayPal:

| Constant | Event name | Fires when |
|---|---|---|
| `CHECKOUT_CREATE_ORDER_REQUEST` | `commerce_paypal.checkout_create_order_request` | before creating a Checkout order |
| `CHECKOUT_UPDATE_ORDER_REQUEST` | `commerce_paypal.checkout_update_order_request` | before updating a Checkout order |
| `FASTLANE_CREATE_ORDER_REQUEST` / `FASTLANE_UPDATE_ORDER_REQUEST` | `commerce_paypal.fastlane_create_order_request` / `…update_order_request` | Fastlane order create/update |
| `EXPRESS_CHECKOUT_REQUEST` | `commerce_paypal.express_checkout_request` | legacy Express Checkout request |
| `PAYFLOW_CREATE_PAYMENT` / `PAYFLOW_LINK_REQUEST` | `commerce_paypal.payflow_create_payment` / `…payflow_link_request` | Payflow / Payflow Link requests |

Example subscriber:

```php
use Drupal\commerce_paypal\Event\PayPalEvents;
use Drupal\commerce_paypal\Event\CheckoutOrderRequestEvent;

public static function getSubscribedEvents(): array {
  return [PayPalEvents::CHECKOUT_CREATE_ORDER_REQUEST => 'onCreate'];
}

public function onCreate(CheckoutOrderRequestEvent $event): void {
  $request = $event->getRequestBody();   // array sent to PayPal
  // ...mutate $request...
  $event->setRequestBody($request);
}
```

**Limitation:** every SDK method above performs a live HTTPS call to PayPal and requires
valid credentials + outbound network access; it cannot run in an offline sandbox.
