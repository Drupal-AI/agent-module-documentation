<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce InPost adds InPost parcel-locker (Paczkomat) delivery to Drupal Commerce.

---

Commerce InPost provides **InPost parcel-locker delivery for Drupal Commerce**. It adds a
**fixed-price InPost shipping method** and a **checkout pane** where the shopper selects an InPost
locker on a map. The map is InPost's **client-side "easyPack" geowidget**, loaded in the browser over
HTTPS from `geowidget.easypack24.net`; the module itself makes no server-side call to InPost and
uses no API credentials. The selected locker (name, address and a delivery phone number) is saved on
the order and shown on the review step and on the admin/customer order views. It depends on Commerce,
Commerce Checkout, Commerce Shipping and Commerce Order, in the Commerce (contrib) package.

Use it to let customers choose an InPost locker at checkout. Set it up by creating a shipping method
that uses the **InPost Shipping** plugin (you enter a rate label, optional description and a fixed
rate amount), then enabling the two InPost checkout panes on your checkout flow. Locker choice is
captured in the browser via the geowidget and stored on the order; the module displays it but does
not itself create InPost labels or track shipments — fulfilment is handled outside Drupal using the
captured locker and phone. Output of locker/address data is rendered through Twig auto-escaping and
Form API. It defines no routes and no permissions, so it adds no new access surface of its own.

---

- Offer InPost parcel-locker (Paczkomat) delivery at checkout.
- Add a fixed-price InPost shipping method (rate label, description, amount).
- Let the shopper pick a locker on InPost's client-side easyPack map.
- Load the geowidget over HTTPS from geowidget.easypack24.net (browser side).
- Store the chosen locker (name, address, phone) on the order.
- Show the locker on the review step via a dedicated pane and theme.
- Show the locker on the admin and customer order views.
- Collect a delivery phone number, optionally from an existing user/profile field.
- Depend on Commerce, Commerce Checkout, Commerce Shipping and Commerce Order.
- Render locker/address data through Twig auto-escaping and Form API.
- Define no custom routes and no permissions.
- Capture the locker choice for fulfilment done outside Drupal.
- Use no InPost API credentials and no server-side InPost API call.
- Configure the shipping method under Commerce → Shipping methods.
- Enable the InPost panes on the checkout flow.
- Serve the Polish InPost / Paczkomat market.
- Handle parcel-locker selection.
- Provide InPost shipping.
