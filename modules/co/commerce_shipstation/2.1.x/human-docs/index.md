# Commerce ShipStation — manual setup guide

**Commerce ShipStation** (`commerce_shipstation`) integrates Drupal Commerce with
**ShipStation**, the multi‑channel order‑fulfillment platform. Using ShipStation's
"Custom Store" service, it exports your Commerce orders to ShipStation for
fulfillment and receives updates back when orders ship — marking orders complete
and saving the tracking number on the shipment. It requires a ShipStation account
and Commerce Shipping, and depends on core **Image**.

The integration is driven by an endpoint on your site that ShipStation calls. You
choose which order status triggers export, which field carries order comments to
ShipStation, how billing/shipping phone numbers and product images are handled,
and which shipping methods are exposed to ShipStation. All of that lives on the
module's configuration page.

**Security matters here.** The endpoint authenticates each ShipStation request
against a dedicated store username and password you set in the module — explicitly
**not** your ShipStation login (ShipStation sends them as request parameters; an
optional alternate key is also supported). A signed‑in Drupal user with the *view
any commerce order* permission is likewise allowed. Because the store credentials
and order data (customer names and addresses) travel over that endpoint, **serve
it only over HTTPS**, store the credentials as secrets, and rotate them if they
leak.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — set the connection credentials and
   options in Drupal, then create the matching Custom Store in ShipStation.

## Where it lives in the admin menu

The settings page is at **Commerce → Configuration → Shipping → ShipStation**
(`/admin/commerce/config/shipstation`). The endpoint ShipStation connects to is
`https://[your-domain]/shipstation/drupal-commerce` (a legacy
`/shipstation/api-endpoint` path also still works but is being retired).
