<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce OCI Checkout makes it possible to do Open Catalog Interface checkout.

---

Commerce OCI Checkout enables **Open Catalog Interface (OCI) punch-out checkout** — a B2B e-procurement
flow where a buyer browses your Commerce catalog from within their procurement/ERP system and the cart is
handed back to that system (rather than paid on your site). It depends on Commerce and Commerce Cart and
provides its own permission, `use commerce_oci_checkout`.

The buyer's procurement system starts a session at `/oci/logon` by supplying `hook_url`, `username` and
`password`. Authentication uses an **existing Drupal user account**: the module looks the account up by
email (the `username`) and verifies the `password` through core's `user.auth` service, with a flood gate on
failed attempts — there is no separate shared-secret or credentials config form. The buyer's `hook_url`
(the OCI return endpoint) is stored in the session, the account is logged in, and while that session is
active the punch-out cart is kept isolated in the session. When the buyer finishes, the cart is rendered as
an OCI form at `/oci-cart` and POSTed back to the `hook_url` with server-authoritative prices (calculated
by Commerce's price calculator). Run the exchange over **HTTPS**, grant `use commerce_oci_checkout` only to
the accounts that represent procurement buyers, and keep those accounts' passwords managed as credentials.

To set up: enable the module, create/grant a Drupal user account (with the `use commerce_oci_checkout`
permission) per buyer, and give the procurement system that account's login plus your `/oci/logon`
endpoint. No admin configuration form is required. Item rows and the return form can be customised in code
via the `commerce_oci_checkout_row`, `commerce_oci_item_rows` and `commerce_oci_checkout_form` alter hooks.

---

- Enable OCI punch-out checkout.
- Support B2B e-procurement.
- Hand the cart back to the buyer's system via the OCI HOOK_URL form.
- Depend on Commerce and Commerce Cart.
- Serve procurement systems (SAP SRM, ORDIGES, Microsoft Dynamics AX, SAP Ariba, etc.).
- Browse the catalog from procurement and build a session-isolated cart.
- Authenticate buyers via existing Drupal accounts (email + password, verified by user.auth).
- Use HTTPS for the exchange.
- Gate the flow with the `use commerce_oci_checkout` permission.
- Return the cart with server-authoritative prices.
- Customise OCI rows/form through the module's alter hooks.
- Do B2B checkout via the OCI standard.
