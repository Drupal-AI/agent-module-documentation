<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring Commerce Packeta

## Prerequisites
- Drupal Commerce with `commerce_shipping` and `profile` enabled.
- A Packeta (Zásilkovna) account with an API password and e-shop identifier.
- Products with a weight field populated (submitted in kg).

## Add the shipping method
1. Create a shipping method (`admin/commerce/shipping-methods` or the Commerce Shipping UI) using the **Packeta** plugin.
2. In the plugin `configuration`:
   - `api['api_password']` — Packeta API password (used for the SOAP `createPacket` call).
   - `settings['eshop_url']` — your e-shop id sent as `eshop`.
   - the profile phone field name used to read `phone` from the billing profile.
3. Ensure the checkout flow renders the Packeta pickup-point selector so `packeta_pickup_point` (with `id`) is saved on the shipment.

## Packet submission
`PacketaApiClient::submitShipmentToPacketa($shipment)` builds the payload from the order + billing profile:
- `number` (order number), `email`, `phone`, `currency`, `value` (order price), optional `cod` (= total when COD), `weight` (kg), `eshop`, and the pickup point `id`.
- Calls `SoapClient("https://www.zasilkovna.cz/api/soap.wsdl")->createPacket($api_password, $packet_array)` and returns `$packet->id`.
- On `SoapFault` it logs fault + serialized detail to the `commerce_packeta` logger and returns `''`.

## Helper views (submodule)
Enable `commerce_packeta_views` (needs `views_bulk_edit`) to get a product-variation view with a bulk operation for setting weights.