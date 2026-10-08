<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce ShipStation integrates Commerce with ShipStation, an online multi-channel order fulfillment system, exposing an authenticated endpoint for ShipStation to fetch/update orders.

---

Commerce ShipStation integrates Drupal Commerce with ShipStation — an online multi-channel order-
fulfillment/shipping platform. It exposes an endpoint that ShipStation calls to fetch orders for
fulfillment and post shipment/tracking updates back, so orders flow between the store and ShipStation. It
depends on core Image and is configured at `commerce_shipstation.shipstation_admin_form`.

The endpoint is authenticated: each ShipStation request is checked against a dedicated store username and
password you configure in the module (explicitly "NOT your ShipStation account username") — ShipStation sends
them as request parameters (`SS-UserName`/`SS-Password`), and an optional alternate `auth_key` is also
supported. A signed-in Drupal user with the `view any commerce_order` permission is likewise allowed. The
operational points: store the endpoint username/password (and any alternate key) as secrets, **serve the
endpoint only over HTTPS** (ShipStation transmits the store credentials with each call and the endpoint
carries order data — customer names/addresses), and rotate the credentials if leaked. It is an e-commerce
integration; configure the ShipStation credentials and the endpoint.

---

- Integrate Commerce with ShipStation.
- Sync orders for fulfillment.
- Expose an authenticated ShipStation endpoint.
- Authenticate each request with a dedicated username/password (or alternate key).
- Post shipment/tracking updates back.
- Depend on core Image.
- Configure at the shipstation admin form.
- Store endpoint credentials as secrets.
- Serve the endpoint over HTTPS.
- Rotate credentials if leaked.
- Fetch orders for ShipStation.
- Handle multi-channel fulfillment.
- Protect customer order data in transit.
- Authenticate ShipStation to the endpoint.
- Configure the ShipStation connection.
- Support order fulfillment.
- Handle shipping updates.
- Secure the endpoint.
- Sync tracking numbers.
- Integrate fulfillment.
