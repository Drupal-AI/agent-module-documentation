<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Bitcoin (BTC) payment method to the contrib Basket commerce module, generating a Bitaps payment address per order and marking the order paid when Bitaps reports the payment confirmed.
---
Bitaps registers a `BasketPayment` plugin (`BasketBitaps`, id `bitaps`) so a store built on the contrib **Basket** module can offer "Bitaps payment" as a checkout option. When a customer chooses it, the module records a pending row in its own `payments_bitaps` table (the `Bitaps` service), then calls the Bitaps HTTP API (`https://api.bitaps.com/btc/v1/create/payment/address`) to allocate a receive address bound to the site's forwarding address, required confirmation count, and a callback URL. The customer is shown that address on a hosted payment page at `/bitaps/pay`. When the on-chain payment reaches the configured number of confirmations, Bitaps POSTs a status notification to `/bitaps/status`; the controller checks the notification's `hash` query parameter against a SHA-256 value recomputed from the payment id, amount and the site's configured secret key, updates the stored status, and (on a `confirmed` event) calls Basket's `paymentFinish()` to complete the order and optionally fires a Basket Noty notification.

Configuration lives at `/admin/config/development/bitaps` (`bitaps.settings`, permission `access bitaps settings`): a secret key, a forwarding address, a required-confirmations count, and the currency (BTC). The module only supports BTC and depends functionally on the Basket ecosystem — it is not a standalone gateway and does not integrate with Drupal Commerce. Setup: install and enable Basket, enable this module, enter the Bitaps credentials on the settings form, then add a Basket payment point using the "Bitaps" service and pick the order status to apply after payment.
---
- Accept Bitcoin payments on a store built with the contrib Basket module.
- Offer "Bitaps" as a selectable Basket payment method (`BasketBitaps` plugin).
- Allocate a fresh Bitaps receive address per order via the Bitaps BTC API.
- Forward received coin to a configured forwarding (settlement) address.
- Require a configurable number of on-chain confirmations before crediting.
- Show customers a hosted payment page with the address and amount at `/bitaps/pay`.
- Receive Bitaps status notifications at the `/bitaps/status` callback route.
- Recompute a SHA-256 hash of payment id + amount + secret key to check the callback.
- Update a payment's status from the callback event (e.g. to `confirmed`).
- Complete the Basket order via `paymentFinish()` once payment is confirmed.
- Set the post-payment order status per payment point (`fin_status` term selector).
- Record each payment (nid, uid, amount, currency, status, timestamps) in `payments_bitaps`.
- Look up a payment by id, node id, or session id through the `Bitaps` service.
- Configure secret key, forwarding address, confirmations, and currency in one settings form.
- Restrict gateway configuration behind the `access bitaps settings` permission.
- Fire a Basket Noty "change_bitaps_status" notification action on status change (if `basket_noty` is enabled).
- Expose the current Bitaps payment status as a `bitaps_status` Basket Noty twig token.
- Localise the UI via the module's `bitaps` translation context (ships a Russian `.po`).
- Customise the payment page markup through the `bitaps_pay` theme hook / `bitaps-pay.html.twig`.
- Alter outgoing address-creation parameters via `hook_bitaps_payment_params_alter()`.
- React to a confirmed payment via `hook_bitaps_api_alter()`.
- Theme the address/amount block with the module's bundled `bitaps/css` library.
