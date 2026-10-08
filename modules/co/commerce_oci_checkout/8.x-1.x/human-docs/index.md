# Commerce OCI Checkout — manual setup guide

**Commerce OCI Checkout** (`commerce_oci_checkout`) enables **Open Catalog Interface
(OCI) punch-out checkout** on a Drupal Commerce site. OCI is a standard format used
by ERP and purchasing systems — SAP Supplier Relationship Management, ORDIGES
Purchase-to-Pay, Microsoft Dynamics AX and others — to connect to external
punch-out catalogs. With this module your Drupal Commerce store acts as the
**supplier**, and a B2B buyer browses your catalog from *inside their own
procurement system*, then the assembled cart is handed back to that system rather
than being paid for on your site.

The problem it solves is B2B sales through the OCI standard, which is widely used in
Europe. Instead of a normal checkout-and-pay flow, the buyer's procurement portal
"punches out" to your catalog, the buyer selects items, and the cart contents are
returned to the procurement system for approval and purchasing there. It depends on
Drupal **Commerce** (`commerce`) and **Commerce Cart** (`commerce_cart`), and it
provides its own permissions.

This is not a plain works-on-enable module: an OCI integration involves giving the
buyer's procurement system login credentials for a Drupal account on your store and
coordinating the punch-out endpoints. Because it changes how checkout behaves for
punch-out sessions, plan the integration with the procurement system's operator.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module and its Commerce dependencies.

## How to use it

Once enabled, the module supports the OCI punch-out round trip:

1. The buyer's procurement system opens a punch-out session at your store's
   `/oci/logon` endpoint, passing `hook_url` (the OCI return address), `username`
   and `password`.
2. The module authenticates that against an **existing Drupal user account** (it
   looks the account up by email and verifies the password), logs the buyer in, and
   remembers the return `hook_url` for the session.
3. The buyer browses your Commerce catalog and builds a cart as usual (kept isolated
   in the punch-out session).
4. On "checkout", instead of paying, the cart is rendered at `/oci-cart` and posted
   back to the buyer's `hook_url` in OCI format for purchasing on their side, with
   prices calculated server-side by Commerce.

## Security and credentials

Buyers authenticate with an **ordinary Drupal user account** — there is no separate
credentials-config form. Create one account per buyer (or per procurement system),
grant it the `use commerce_oci_checkout` permission, and hand the procurement system
that account's login plus your `/oci/logon` endpoint. Treat those account passwords
as credentials and manage them accordingly. Always run the exchange over **HTTPS**.
The module has no broad access-control role beyond the permission it provides, so
grant `use commerce_oci_checkout` only to the accounts that should operate the OCI
integration. Prices in the returned cart are always computed on the server, so buyer
input cannot set them.
