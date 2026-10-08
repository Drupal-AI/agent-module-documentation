<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Coinbase gateway

**Plugin:** `Coinbase extends OffsitePaymentGatewayBase`, id `coinbase_payment`.
- `defaultConfiguration()`/`buildConfigurationForm()` expose a single `coinbase_api_key` textfield.

**Offsite redirect** (`CustomPaymentOffsiteForm::buildConfigurationForm`):
1. Reads `$payment->getAmount()` number/currency.
2. cURL `POST https://api.commerce.coinbase.com/charges/` with header `X-CC-Api-Key: <coinbase_api_key>` and body `{"local_price":{"amount":"…","currency":"…"},"pricing_type":"fixed_price"}` (string-concatenated at lines 48-49).
3. Redirects the buyer to `$res['data']['hosted_url']`.

**Gaps / observations:**
- No `onReturn(OrderInterface, Request)` override and no `onNotify(Request)` — the class inherits the base and the module ships an **empty routing.yml**, so there is no `commerce_payment.notify.coinbase_payment` handler.
- Consequence: nothing verifies the Coinbase Commerce webhook (no `X-CC-Webhook-Signature` HMAC check) and no `commerce_payment` entity is created/completed from a confirmed charge — payment success is never validated server-side.
- cURL call uses defaults (`CURLOPT_SSL_VERIFYPEER` not disabled), so TLS verification is on.
