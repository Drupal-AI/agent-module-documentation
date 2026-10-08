# tapin — manual setup guide

**tapin** (`tapin`) connects your Drupal Commerce store to an external *tapin*
logistics/fulfilment service. It gives that service a small set of REST
endpoints for pulling the orders that are ready to be shipped, and for writing a
scanned barcode and an external tapin order id back onto each order once it has
been picked. It also ships a simple React-based admin screen where staff can see
the fulfilment queue in the browser.

Under the hood the module adds three fields to your commerce order type on
install — `field_tapin_order_id`, `field_tapin_check`, and `field_barcode_tapin`
— and exposes three cookie-authenticated REST resources: one that returns the
stored integration token, one (`POST /api/tapin/get-order`) that lists pending
fulfilment orders with paging and full customer profile data, and one
(`POST /api/tapin/update-order`) that marks an order as checked and saves the
barcode. It depends on Drupal Commerce (both `commerce` and `commerce_order`)
and core's REST module.

The module needs some configuration before it is useful: you set an integration
token and related options on its settings form, then grant the REST permissions
to a dedicated service account so the tapin service can reach the endpoints.
Please take the access notes seriously — the `get-order` response includes
customer personal data (name, mobile number, address), and `update-order` will
mark *any* order id it is handed as checked with no ownership check, so the REST
permissions must only ever be given to the trusted tapin integration account,
never to anonymous or general users.

This guide is written for a **human** setting the module up through the admin UI.
If you want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and confirm the order fields and endpoints appeared.
2. [Configuration](configuration/index.md) — the settings form, the permissions
   to grant (and to whom), and how the REST endpoints and the order screen work.

## Where it lives in the admin menu

Once enabled, the settings form sits at **Configuration → System → tapin**
(`/admin/config/system/tapin`). A staff-facing order screen lives at
`/admin/config/system/tapin/main`, and the React order dashboard renders at
`/admin/config/system/tapin/list`.

## How to use it

Operators typically: fill in the settings form, create a dedicated Drupal user
for the tapin service and grant it only the REST permissions it needs, then point
the external tapin service at the endpoints. The service reads the pending
fulfilment queue with `POST /api/tapin/get-order` (paging through results with
`page` and `limit`, or narrowing to one order with `order_id`), and once an order
is scanned it calls `POST /api/tapin/update-order` to store the barcode and the
external order id and flag the order as checked. Only orders in the
`fulfillment` state with `field_tapin_check = 0` appear in the queue.
