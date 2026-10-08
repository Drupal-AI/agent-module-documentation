<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Mondial Relay provides Mondial relay pick up shipping functionality.

---

Commerce Shipping Mondial Relay adds **Mondial Relay pick-up-point ("Point Relais") shipping** to
Drupal Commerce — letting customers choose a Mondial Relay parcel-shop as the delivery point at
checkout (common in France and much of Europe). It depends on Commerce Shipping and is in the
Commerce (contrib) package.

Use it to offer Mondial Relay delivery. It adds a **Mondial Relay shipping method** (a flat rate you
set in config) and a **checkout pane** that embeds **Mondial Relay's own hosted browser widget** so
the customer can search a map for a nearby parcel shop; the chosen relay point and its address are
carried into the order's shipment (stored on a `mondial_relay` profile). The pickup-point search runs
in the browser against Mondial Relay's servers via the hosted widget script — the module makes no
server-side carrier API call and stores no API secret. The widget's **Brand** ("Enseigne") code is a
public identifier the browser widget needs. The Mondial Relay pane requires the Shipping information
pane (from `commerce_shipping`) to be present. Serve checkout over HTTPS. It has no access-control
role or permission of its own.

---

- Offer Mondial Relay pick-up shipping.
- Let customers pick a parcel-shop.
- Serve France/Europe delivery.
- Depend on Commerce Shipping.
- Add a Mondial Relay shipping method.
- Set a flat shipping rate in config.
- Embed the Mondial Relay pickup widget.
- Search pick-up points in the browser.
- Carry the chosen relay point into the shipment.
- Store the pickup point on a mondial_relay profile.
- Configure the Brand (Enseigne) code.
- Configure widget display options.
- Add the Mondial Relay checkout pane.
- Require the Shipping information pane.
- Use HTTPS at checkout.
- Have no access-control role.
- Provide Mondial Relay shipping.
- Handle Mondial Relay.
- Offer parcel-shops.
- Configure Commerce shipping.
