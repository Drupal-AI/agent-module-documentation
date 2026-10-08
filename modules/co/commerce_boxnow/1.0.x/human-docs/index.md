# Commerce BOXNOW — manual setup guide

**Commerce BOXNOW** (`commerce_boxnow`) integrates the **BOX NOW** parcel‑locker
delivery service into Drupal Commerce as a **shipping method**. It lets customers
choose a BOX NOW locker for delivery at checkout and syncs shipment data with the
BOX NOW API, giving merchants a fast, secure last‑mile option. It depends on
Commerce Shipping (`commerce_shipping`).

Once enabled, you add BOX NOW as a shipping method, enter the API credentials BOX
NOW provides, and configure the usual shipping settings (pricing, region
restrictions, availability). At checkout, customers can pick a locker location,
and the module communicates with BOX NOW for shipping statuses.

Because it talks to an external service, a couple of data‑handling points matter:
the module makes **outbound calls to the BOX NOW API** using your **API
credentials** (store these as secrets, over HTTPS), and it sends **order and
recipient details** (names, addresses — personal data) to BOX NOW so parcels can
be delivered. Disclose that data sharing in your privacy policy. The module itself
has no access‑control role. (Note: it is a community integration and is not
affiliated with the BOX NOW company.)

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and Commerce Shipping.
2. [Configuration](configuration/index.md) — add the BOX NOW shipping method and
   enter your API credentials.

## Where it lives in the admin menu

BOX NOW is configured as a shipping method under **Administration → Commerce →
Configuration → Shipping methods**
(`/admin/commerce/config/shipping-methods`) — see
[Configuration](configuration/index.md).
