<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
tapin connects Drupal Commerce orders to an external tapin logistics service through REST resources and a small admin order screen.

---

The module adds order fields (`field_tapin_order_id`, `field_tapin_check`, `field_barcode_tapin`) and exposes three REST resources (cookie-authenticated): `GET /api/tapin-gettokenrestresource` returns the stored `token` config value; `POST /api/tapin/get-order` returns pending fulfilment orders (state `fulfillment`, `field_tapin_check = 0`) with paging and full customer profile data (name, mobile, address); and `POST /api/tapin/update-order` marks an order checked (`field_tapin_check = 1`) and writes back a barcode and tapin order id. A React-based admin page at `/admin/config/system/tapin/list` renders the order UI, and a settings form lives at `/admin/config/system/tapin`.

Access uses core REST permissions (`restful get|post <plugin_id>`) plus the module's own `administer tapin configuration` (restricted) and `access order page` permissions; the order-list route is gated only by `access content`. The `get-order` response includes customer PII and `update-order` mutates orders by client-supplied order id without an ownership check, so the REST permissions should be granted only to the trusted tapin integration account. Operators configure the settings form, grant the REST permissions to a service user, and point the tapin service at these endpoints.
---
- Install with Commerce and the core REST module enabled.
- Configure the module at `/admin/config/system/tapin` (settings form).
- Grant `administer tapin configuration` (restricted) to admins only.
- Grant the REST resource permissions to the trusted tapin service account.
- Expose pending fulfilment orders to the tapin service via `POST /api/tapin/get-order`.
- Page through fulfilment orders using `page` and `limit` in the request body.
- Filter the order list to a single order by `order_id` (order number).
- Return customer profile data (name, mobile, address, city, postal code) per order.
- Mark an order as tapin-checked via `POST /api/tapin/update-order`.
- Write a scanned barcode back onto an order (`field_barcode_tapin`).
- Store the external tapin order id on `field_tapin_order_id`.
- Fetch the configured integration token via `GET /api/tapin-gettokenrestresource`.
- View the React order dashboard at `/admin/config/system/tapin/list`.
- Add the tapin order/barcode/check fields to the default commerce order type on install.
- Restrict order-page access with the `access order page` permission.
- Let only orders in state `fulfillment` with check=0 appear in the queue.
- Integrate a barcode/QR scanning client (dompurify/html2canvas bundled) with the order UI.
