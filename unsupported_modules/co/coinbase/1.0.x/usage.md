<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Coinbase adds an off-site Drupal Commerce payment gateway that sends shoppers to a Coinbase Commerce hosted checkout to pay in cryptocurrency.

---
The gateway plugin (`Coinbase`, extending `OffsitePaymentGatewayBase`) stores a single `coinbase_api_key`. Its offsite form (`CustomPaymentOffsiteForm`) builds a JSON charge body from the order amount/currency and `POST`s it to `https://api.commerce.coinbase.com/charges/` with the `X-CC-Api-Key` header, then redirects the buyer to the returned `hosted_url`.

Security observations to report: the module implements no `onReturn()` or `onNotify()` handler and declares no webhook/notify route, so there is no server-side verification that a charge was actually paid and no Commerce payment is created/completed from a Coinbase callback — payment state is effectively never confirmed. The charge request is built by string-concatenating amount/currency into the JSON body (`CustomPaymentOffsiteForm.php:48-49`); TLS is left at cURL defaults (verification on). Setup: create the gateway, paste the Coinbase Commerce API key, and add it to a checkout flow — but note the missing return/notify verification.
---
- Add a Coinbase Commerce payment gateway.
- Store the Coinbase Commerce API key.
- Let customers pay in cryptocurrency.
- Create a Coinbase charge from an order total.
- Redirect buyers to the Coinbase hosted checkout.
- Configure return and cancel URLs.
- Offer crypto as a checkout option.
- Use fixed-price charges.
- Test the gateway in a sandbox store.
- Restrict gateway configuration to store admins.
- Review the missing onReturn/onNotify handling before production.
- Add webhook signature verification (currently absent).
- Reconcile Coinbase payments manually.
- Map order currency to the charge currency.
- Style the offsite redirect form.
- Audit how payment completion is recorded.
