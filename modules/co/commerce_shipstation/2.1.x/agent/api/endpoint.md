<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ShipStation endpoint, auth & actions

The whole integration is one HTTP endpoint that ShipStation's **Custom Store** calls. No outbound
HTTP is made by this module.

## Routes (`commerce_shipstation.routing.yml`)

- `commerce_shipstation.drupal_commerce` → path **`/shipstation/drupal-commerce`** (current).
- `commerce_shipstation.shipstation_endpoint` → path **`/shipstation/api-endpoint`** (legacy; the
  admin form prints a notice that it will be removed — point new Custom Stores at
  `/shipstation/drupal-commerce`).

Both map to `ShipStationEndpointController::shipStationEndpointRequest` (title "ShipStation API
Callback URI"), carry `requirements: { _shipstation_access: 'TRUE' }`, and
`options: { _auth: ['basic_auth','cookie'], no_cache: TRUE }`. The controller also triggers
`page_cache_kill_switch` per request.

Admin/config route: `commerce_shipstation.shipstation_admin_form` →
**`/admin/commerce/config/shipstation`**, permission **`administer commerce_shipment`**
(menu link under *Commerce → Configuration → Shipping → ShipStation*).

## Access / authentication (`_shipstation_access`)

Access check `commerce_shipstation.shipstation_access`
(`Access\ShipStationAccess::access()`) tagged `access_check, applies_to: _shipstation_access`. A
request is allowed when **any** of these holds:

1. A signed-in Drupal user (cookie auth) who has the **`view any commerce_order`** permission.
2. `ShipStation::access()` matches the request's `?SS-UserName=` and `?SS-Password=`
   **query-string** parameters against the configured store username/password
   (`commerce_shipstation_username` / `commerce_shipstation_password`).
3. `ShipStation::access()` matches the request's `?auth_key=` against the configured
   `commerce_shipstation_alternate_auth` (the "Alternate Authentication" field, for CGI-PHP
   servers). On no match it throws `AccessDeniedHttpException`.

These are the credentials you create on the settings form (deliberately **separate** from your
ShipStation login) and re-enter when adding the Custom Store in ShipStation. Serve the endpoint over
**HTTPS**: ShipStation transmits the store credentials with each call and the endpoint carries order
data.

## Dispatch (`ShipStationEndpointController::shipStationEndpointRequest`)

1. Kill the page cache; if the config object is empty → `503 ServiceUnavailable`
   ("Integration is not configured.").
2. Decrement `?page` by 1 (ShipStation pages from 1, Drupal from 0).
3. If `commerce_shipstation_logging` is on, log the request query (with `SS-UserName`/`SS-Password`
   obfuscated to `******`).
4. Switch on `?action=`:
   - **`export`** → `ShipStation::exportOrders($start_date ?: '-1 day', $end_date ?: 'now', $page)`;
     returns `Content-type: application/xml`.
   - **`shipnotify`** → `ShipStation::requestShipNotify($order_number, $tracking_number, $carrier,
     $ship_date)`; returns the text result.
   - anything else → error message + `AccessDeniedHttpException`.

## `export` action — order → XML (`ShipStation::exportOrders`)

- Loads `commerce_order` entities whose `state` is IN the configured
  `commerce_shipstation_export_status` set. Unless `commerce_shipstation_reload` is on, also
  constrains `changed BETWEEN [start,end]` (timestamps from `?start_date`/`?end_date`, parsed in the
  site timezone). Pages by `commerce_shipstation_export_paging`. `accessCheck(FALSE)` (the endpoint
  access check has already run).
- `hook_commerce_shipstation_export_orders_alter($orders, $context)` lets other modules filter the
  order list.
- Per order it emits an `<Order>` with `<Customer>` → `<BillTo>` / `<ShipTo>`, `<Items>` (product
  variations: SKU, title, quantity, adjusted unit price, weight, optional thumbnail ImageUrl), and
  promotion/tax adjustments. Only orders that have a shipment **and** a shipping method present in
  `commerce_shipstation_exposed_shipping_methods` are emitted; orders without a shipping profile or
  shipping line item are skipped.
- Text values go through CDATA (`ShipStationSimpleXMLElement::addCdata`). Output via
  `dom_import_simplexml(...)->ownerDocument->saveXML()` with `formatOutput = TRUE`, plus a `pages`
  attribute for ShipStation paging. `hook_commerce_shipstation_order_xml_alter(&$order_xml, $order)`
  fires per order; the event `ShipStationEvents::ORDER_EXPORTED`
  (`commerce_shipstation.order_exported`, payload `ShipStationOrderExportedEvent::getOrder()`) is
  dispatched per exported order.

## `shipnotify` action — inbound fulfilment (`ShipStation::requestShipNotify`)

Requires `order_number` and `carrier` (else `NotFoundHttpException`). Loads the order by
`order_number` (`loadByProperties`), takes the shipment `shipments[0]`, sets the tracking code and
shipped time (`?ship_date` in the site timezone, default "now"), saves the shipment, then applies
the order's **`fulfill`** state transition if allowed (logs a warning if the workflow has no
`fulfill` transition) and saves the order. Returns a "Tracking information was received
successfully" message. Unknown order → `NotFoundHttpException`.
