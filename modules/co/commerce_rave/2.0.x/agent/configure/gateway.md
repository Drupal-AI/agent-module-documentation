<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure the Rave payment gateway

## Prerequisites
- Drupal Commerce with `commerce_payment` enabled.
- A Flutterwave Rave account with a **public key** and **secret key**.
- No non-Drupal PHP libraries are required.

## Add the gateway
1. Go to **Commerce > Configuration > Payment gateways** (`/admin/commerce/config/payment-gateways`) and **Add payment gateway**.
2. Choose the **Rave** plugin (id `rave`, off-site redirect).
3. Set **Mode** — `Live` (`https://api.ravepay.co`) or `Staging` (test).
4. Fill the plugin fields (`Rave::buildConfigurationForm`):
   - **Public key** (required) — `public_key`.
   - **Secret key** (required) — `secret_key`. Used server-side for verification and the checkout integrity hash.
   - **Payment flow** — `iframe` (inline card form) or `hosted_payment_page` (redirect to Flutterwave's hosted page).
   - **Pay button text** (optional) — `pay_button_text`.
   - **Transaction Reference Prefix** (optional, default `rave`) — `txref_prefix`; the order reference sent to Rave is `{txref_prefix}-{orderId}`.
5. Save.

## Permissions
No module-specific permissions. Use the standard Commerce **Administer payment gateways** permission to add/edit the gateway.

## Key handling notes
- The secret key is stored in the payment-gateway configuration as a string (Commerce baseline; the module does not integrate the Key module). Restrict who holds *Administer payment gateways* and keep exported payment-gateway config out of version control.
- Serve checkout over HTTPS and prefer **Live** mode (HTTPS endpoint) for real transactions; Staging targets a legacy Rave v3 test host.

## What happens at checkout
See [../payment/verification.md](../payment/verification.md) for the build → return → verify sequence.
