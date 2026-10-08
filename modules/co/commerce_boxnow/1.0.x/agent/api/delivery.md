<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BOX NOW API client & order-place subscriber

## Service `commerce_boxnow.service` (`CommerceBoxNowService`)

Constructor args (`.services.yml`): `@http_client` (Guzzle), `@current_user`,
`@config.factory`, `@logger.factory`, `@entity_type.manager`, `@database`. Uses
`DependencySerializationTrait`. Two endpoint path constants:
`AUTHENDICATION_PATH = /api/v1/auth-sessions`, `REQUEST_DELIVERY_PATH = /api/v1/delivery-requests`
(appended to the configured `api_url`). Logger channel: `commerce_boxnow`.

### Config lookup

- `getBoxNowShippingMethodId()` — `ShippingMethod::loadMultiple()`, returns the id of the
  first method whose plugin id is `boxnow_shipping` (no empty-guard on `[0]`).
- `getBoxNowConfiguration()` — loads that shipping method and returns its
  `plugin[0].target_plugin_configuration` array (the fields documented in
  [config/shipping-method.md](../config/shipping-method.md)), or `[]`/`FALSE` if none.

### OAuth token (`client_credentials`)

- `refreshToken()` (protected): POSTs JSON `{grant_type: client_credentials, client_id,
  client_secret}` to `api_url + /api/v1/auth-sessions` via a Guzzle `Request`
  (`Content-Type: application/json`, `sendAsync()->wait()`). On success it caches
  `{token, expiration}` in Drupal **state** key `boxnow_api_token`, where
  `expiration = time() + expires_in - 60` (a one-minute safety buffer). Returns the token
  string, or `FALSE` on any error (missing config, JSON error, request failure, unexpected
  body).
- `getToken()` (public): returns the cached `boxnow_api_token` if still valid
  (`expiration > time()`), otherwise calls `refreshToken()`. Returns token or `FALSE`.

Guzzle is used with default options (TLS certificate verification on).

### `requestDelivery(array $order)`

Gets a token (bails if none) and the config, then POSTs to
`api_url + /api/v1/delivery-requests` with `Authorization: Bearer <token>`. Payload built
from the `$order` array + origin config:

```
orderNumber        = $order['number']
invoiceValue       = $order['invoice_value']
paymentMode        = 'prepaid'          (hard-coded)
amountToBeCollected= '0.00'             (hard-coded, no COD)
notifyOnAccepted   = config notify_on_accepted
origin             = { contactNumber/Email/Name = config contact_*, locationId = contact_location (default '2') }
destination        = { contactNumber = $order['phone'], contactEmail = $order['email'],
                       contactName = $order['name'], locationId = $order['destination_locationId'] }
items              = [ { id:'1', name:'voucher', value:'0.00', compartmentSize:2, weight:$order['total_weight'] } ]
```

Returns `['id' => <request id>, 'parcel_id' => [<parcel ids>]]` on success, or `FALSE` on
error. All failures are logged to the `commerce_boxnow` channel.

## Event subscriber `commerce_boxnow.order_place_subscriber`

`EventSubscriber/OrderPlaceSubscriber` — subscribes to
`commerce_order.place.post_transition` → `onPlaceHandler(WorkflowTransitionEvent)`. Args:
`@commerce_boxnow.service`, `@messenger`, `@logger.factory`.

`onPlaceHandler()`:
1. Gets the order entity; bails (logs) if not an `OrderInterface`.
2. Reads `order.shipments` referenced entities; returns if none.
3. Takes `shipments[0]`; returns if its shipping method plugin id is not `boxnow_shipping`.
4. Gets the shipping profile; logs + returns if missing.
5. Builds the `$order` array: `number` = order number, `invoice_value` = total price number,
   `phone` = `$shipment->getData('boxnow_telephone')`, `email` = order email,
   `name` = profile `address.given_name . ' ' . family_name`,
   `destination_locationId` = `$shipment->getData('locker_id')`, `total_weight` = **0** (hard-coded).
6. Calls `CommerceBoxNowService::requestDelivery($order)`.
7. If the result lacks `id`/`parcel_id`, logs an error and returns.
8. Otherwise saves `$shipment->setData('request_id', $result['id'])` and
   `setData('parcel_id', $result['parcel_id'][0])`, then `$shipment->save()`.

So the BOX NOW delivery is created exactly once, at order-placement, from data captured in
the checkout pane. The module does not poll or receive delivery-status callbacks; the
request/parcel ids stored on the shipment are the integration's only persisted BOX NOW
references.
