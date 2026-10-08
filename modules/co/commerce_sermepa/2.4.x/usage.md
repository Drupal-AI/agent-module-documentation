<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Sermepa integrates Drupal Commerce with **Redsýs** (formerly Sermepa), the "TPV Virtual" card-payment platform used by most Spanish banks. It adds an off-site payment gateway: at checkout the shopper is redirected to Redsýs to pay by card, and Redsýs posts an asynchronous notification back that records the Commerce payment. For a Spanish shop this is usually the payment gateway, not one option among many.

---

The module is a thin Commerce integration over the `commerceredsys/sermepa ^1.0.9` PHP library, which implements the Redsýs protocol (parameter encoding, request signing, response verification). `src/Plugin/Commerce/PaymentGateway/Sermepa.php` defines the `@CommercePaymentGateway` plugin (id `commerce_sermepa`), extending `OffsitePaymentGatewayBase` and implementing `HasPaymentInstructionsInterface`; `src/PluginForm/OffsiteRedirect/SermepaForm.php` builds the auto-submitting POST redirect to Redsýs. It has no routing file of its own — the return and notify endpoints are Commerce's standard payment routes (`commerce_payment.notify`), which is the correct arrangement for an off-site gateway. Configuration is stored on the payment-gateway config entity: merchant name, merchant code (FUC), terminal, the SHA-256 merchant secret key, merchant group, allowed pay methods, consumer language, currency (numeric ISO 4217, default `978`/EUR — limited to the site's enabled currencies), transaction type, and post-checkout instructions; a `test`/`live` mode selects the Redsýs endpoint. The notification handler (`onNotify` → `processRequest`) validates the Redsýs response, then creates a `commerce_payment` for `Ds_Amount/100` with `remote_id = Ds_AuthorisationCode`, mapping the transaction type to a Commerce payment state; a persistent lock keyed by order UUID serializes the browser return and the async notify so the order is not processed twice. The merchant key is a secret best sourced from an environment variable rather than exported configuration. The module ships `ludwig.json` so the library can be installed without Composer, and the release carries the legacy `8.x-2.4` version string while requiring core `^10 || ^11`.

---

- Take card payments through a Spanish bank via Redsýs.
- Integrate Redsýs / Sermepa with Drupal Commerce checkout.
- Provide the standard payment gateway for a Spanish shop.
- Redirect shoppers off-site to the bank's hosted card form.
- Record Commerce payments from the bank's asynchronous notification.
- Configure the merchant code, terminal, and secret key from the bank.
- Switch between the Redsýs test and production environments.
- Accept payments in euros (or another enabled numeric currency) through a local acquirer.
- Install the Redsýs protocol library without Composer using ludwig.json.
- Support Commerce 2 or Commerce 3 on Drupal 10 or 11.
- Reconcile orders with bank notifications by authorisation code.
- Handle asynchronous payment confirmation and browser return without double-processing.
- Map a Redsýs transaction type to a Commerce payment state (authorization/completed/refunded).
- Restrict the allowed payment methods offered to the shopper.
- Follow the current site language in the Redsýs UI (dynamic language option).
- Show custom post-checkout payment instructions to the buyer.
- Meet a Spanish acquirer's mandated integration requirement.
- Test the flow against the Redsýs sandbox endpoint.
- Keep merchant credentials out of code by sourcing the key from the environment.
- Serialize concurrent notify/return requests with a per-order persistent lock.
