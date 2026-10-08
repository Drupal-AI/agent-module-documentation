<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Carrier adds shipping-carrier config entities and tracking links for Drupal Commerce Shipping.

---

Commerce Shipping Carrier lets an admin define named shipping carriers (UPS, DHL, local couriers, etc.)
as configuration entities, each holding a tracking-URL pattern with a `[tracking_code]` placeholder. It
also adds a `shipping_carrier` reference field to shipments, so you can pick a carrier when creating a
shipment; the module then substitutes the shipment's tracking number into the carrier's pattern to render
a clickable tracking link. It fills the gap where flat-rate shipping methods provide no tracking URL (the
D7 `simple_package_tracking` idea). It depends on Commerce Shipping, provides its own permission, and lives
in the Commerce (contrib) package.

Carriers are managed at Commerce → Configuration → Shipping → Carriers
(`/admin/commerce/config/shipping_carriers`). Management is gated by the `administer commerce_shipping_carrier`
permission; the module computes no shipping cost or rate and calls no external carrier API — it only builds a
tracking link from admin-configured config plus the tracking number entered on the shipment.

---

- Define shipping carriers (UPS/DHL/etc.) as config entities.
- Give each carrier a tracking-URL pattern with a `[tracking_code]` placeholder.
- Add a `shipping_carrier` reference field to shipments.
- Select a carrier when creating a shipment.
- Turn a shipment's tracking number into a tracking link.
- Fall back to the plain tracking code when no carrier or URL is set.
- Fill the gap for flat-rate methods that lack tracking URLs.
- Manage carriers at Commerce → Configuration → Shipping → Carriers.
- Gate carrier management behind a permission.
- Depend on Commerce Shipping.
- Provide its own permission.
- Model carriers as configuration.
- List carriers with label and URL pattern.
- Expose the carrier label to the shipment-confirmation email template.
- Compute no shipping cost or rate.
- Call no external carrier API.
- Add carrier entities.
- Configure carrier tracking URLs.
- Name shipping carriers.
- Handle carrier config.
