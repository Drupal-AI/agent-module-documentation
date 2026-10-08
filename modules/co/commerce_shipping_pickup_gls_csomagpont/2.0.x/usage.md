<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Shipping Pickup GLS CsomagPont provides pickup service for GLS CsomagPont (Hungary).

---

Commerce Shipping Pickup GLS CsomagPont adds **GLS CsomagPont pick-up-point shipping** (Hungary) to
Drupal Commerce — letting customers choose a GLS CsomagPont parcel-point as the delivery location at
checkout. It depends on the Commerce Shipping Pickup API module, in the Commerce (contrib) package.

It ships two shipping-method plugins: a **dropdown selector** (pick a locality, then an address) and
a **map selector** that embeds GLS's own point-picker widget. The map selector needs a **Google Maps
JavaScript API key** — a browser (client-side) key that is printed into the page, so restrict it by
HTTP referrer and API in the Google Cloud console rather than relying on secrecy. Pickup-point data
for the dropdown is fetched server-side over HTTPS from GLS's public data feed and cached in a module
table, refreshed on a per-method cron interval.

---

- Offer GLS CsomagPont pickup in Hungary.
- Let customers choose a parcel-point at checkout.
- Provide a locality/address dropdown selector.
- Provide a map-based selector using GLS's widget.
- Restrict the Google Maps browser key by HTTP referrer and API.
- Depend on Commerce Shipping Pickup API.
- Fetch pickup-point data from GLS over HTTPS.
- Cache pickup points in a module table.
- Refresh the pickup list on a cron interval.
- Add the pickup-capable Shipping information checkout pane.
- Add a GLS shipping method in store configuration.
- Set the shipping rate from the method configuration.
- Ship with full Hungarian localization.
- Have no access-control role of its own.
