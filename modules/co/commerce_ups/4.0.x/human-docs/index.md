# Commerce UPS — manual setup guide

**Commerce UPS** (`commerce_ups`) adds UPS as a shipping option in Drupal
Commerce. When a customer reaches checkout, the module calls the UPS REST Rating
API in real time and shows live UPS rates — Ground, Next Day Air, 2nd Day Air,
Worldwide Express and the rest — calculated from the order's shipping address and
the package weight and dimensions.

It plugs into Commerce as a standard **shipping method plugin**, so you add and
configure it exactly where you add flat-rate or FedEx shipping:
**Commerce → Configuration → Shipping methods**. Each shipping method you create
holds its own UPS credentials, so a store can even run several UPS methods with
different accounts. Authentication uses OAuth2 client credentials (a Client ID
and Client Secret from your UPS developer app); the module fetches and caches an
access token automatically, and re-checks connectivity every time you save the
configuration.

Beyond basic rates, Commerce UPS can request your account-specific **negotiated
rates**, apply a **multiplier** to mark shipping up or down, build clickable
**tracking links**, choose a rate **rounding** strategy, and optionally **log**
the UPS request/response for debugging. It ships the standard UPS package types
(10KG/25KG boxes, express boxes, tube) ready to use, caches rate responses for an
hour to keep checkout fast, and reuses OAuth tokens until they expire.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (including the
   required OAuth2 library) and enable the module.
2. [Configuration](configuration/index.md) — the UPS shipping method form, field
   by field: credentials, test/live mode, rate options, tracking and logging.

## Where it lives in the admin menu

Commerce UPS has **no settings page of its own**. You configure it as a shipping
method:

- **Commerce → Configuration → Shipping methods**
  (`/admin/commerce/config/shipping-methods`) — the list of shipping methods.
- **Add shipping method** (`/admin/commerce/config/shipping-methods/add`) — choose
  **UPS** as the plugin to reveal the UPS configuration form.

Access is governed entirely by Commerce's shipping administration permissions —
the module adds no permissions of its own.

## How to use it

1. Create a UPS developer application at the UPS Developer Portal and note its
   **Client ID** and **Client Secret**, plus your UPS **account number**.
2. Install and enable the module (see [Installation](installation/index.md)).
3. Add a shipping method, pick **UPS**, and fill in the credentials and rate
   options (see [Configuration](configuration/index.md)). Start in **test** mode
   to verify everything, then switch to **live**.
4. Make sure your products and order type are set up for Commerce Shipping (each
   shippable product needs weight/dimensions), so UPS has the data it needs to
   quote a rate.
5. At checkout the customer sees the UPS services you enabled, priced live.
