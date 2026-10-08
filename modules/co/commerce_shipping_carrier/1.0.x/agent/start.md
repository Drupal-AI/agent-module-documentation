<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Shipping Carrier — agent start

Version **1.0.0-alpha3**. Core `^9.3 || ^10 || ^11`. Depends on `commerce_shipping`
(composer also requires `commerce ~2.8 || ^3.0`). Package: Commerce (contrib).

Small add-on to Commerce Shipping. Lets an admin define named **carriers** (UPS, DHL,
a local courier) as **config entities**, each holding a tracking **URL pattern**, and turns
a shipment's tracking number into a clickable tracking link. Fills the gap where flat-rate
shipping methods provide no tracking URL (the old D7 `simple_package_tracking` idea).

## What it provides

- **Config entity `commerce_shipping_carrier`** (`src/Entity/Carrier.php`). `config_export`:
  `id`, `label`, `url_pattern`. `admin_permission = "administer commerce_shipping_carrier"`.
  Access via `entity` module's `EntityAccessControlHandler` + `EntityPermissionProvider`;
  routes via `entity`'s `DefaultHtmlRouteProvider`. Config prefix
  `commerce_shipping_carrier.commerce_shipping_carrier`.
  - `getUrlPattern()` — returns the stored pattern string.
  - `getTrackingUrl(ShipmentInterface $shipment)` — reads the shipment's tracking code,
    `str_replace('[tracking_code]', $code, pattern)`, returns `Url::fromUri($url)`; returns
    NULL when the code is empty or `Url::fromUri` throws `InvalidArgumentException`.
- **Admin UI** at `/admin/commerce/config/shipping_carriers` (collection, add, edit
  `.../manage/{id}`, delete). Menu link under Commerce → Configuration → Shipping → Carriers
  (`commerce_shipping.configuration` parent). Form is `src/Form/CarrierForm.php` (label +
  machine name + url_pattern textfields). List builder `src/CarrierListBuilder.php` shows
  Carrier + URL Pattern columns.
- **Permission** (`.permissions.yml`): `administer commerce_shipping_carrier`
  (`restrict access: TRUE`). Note: because the entity uses `EntityPermissionProvider`, the
  `entity` module also derives per-operation permissions for this entity type.
- **Base field on `commerce_shipment`** (`.module`, `hook_entity_base_field_info`):
  `shipping_carrier`, an `entity_reference` (cardinality 1, not required) targeting
  `commerce_shipping_carrier`, shown as an `options_select` on the shipment form. This is how
  a carrier is attached to a shipment.
- **Field formatter override** (`hook_field_formatter_info_alter`): replaces the
  `commerce_tracking_link` formatter class with
  `CarrierTrackingLinkFormatter` (extends Commerce Shipping's `TrackingLinkFormatter`).
  If the shipment has a carrier, it renders a `#type => link` (title = tracking code,
  url = carrier's tracking URL); with no resolvable URL it renders the tracking code via
  `Xss::filterAdmin`; with no carrier it falls back to the parent formatter.

## Configure / use

1. Create carriers at `/admin/commerce/config/shipping_carriers` — give each a label and a
   URL pattern with `[tracking_code]` where the number goes, e.g.
   `https://www.ups.com/track?tracknum=[tracking_code]`.
2. On a shipment, pick the carrier (the added `shipping_carrier` field) and enter the tracking
   number; the tracking-link formatter builds the link from the carrier's pattern.
3. Optional: expose the carrier in the shipment-confirmation email template via
   `{{ shipment_entity.shipping_carrier.entity.label }}`.

## Notes for agents

- No config schema ships (no `config/schema/`) despite the exported config keys.
- `CarrierInterface::getUrlPattern()` docblock claims an array (`length/width/height/unit`) —
  copy-paste leftover from a package-type entity; the value is actually the URL pattern string.
- No external/carrier API is called and no shipping cost/rate is computed here — tracking links
  only. The tracking URL is opened in the customer's browser (a plain link), not fetched
  server-side.

See also human-facing setup: `../human-docs/index.md`.
