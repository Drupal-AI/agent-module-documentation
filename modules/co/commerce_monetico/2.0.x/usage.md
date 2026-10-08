<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Monetico creates an interface between Drupal Commerce and the Monetico payment kit (Cybermut / CIC).

---

Commerce Monetico integrates Drupal Commerce with the Monetico payment kit (Cybermut / CIC / Crédit
Mutuel) — providing a payment gateway that redirects the customer to Monetico for payment and processes the
return/notification. It depends on Commerce Payment, in the Commerce (contrib) package.

Security handling is correct: the callback controller (`CommerceMoneticoRoutingController::response()`)
**verifies the Monetico HMAC-SHA1 seal** — it recomputes the MAC over the returned fields
(`MoneticoHmac::computeHmac`) and only marks the payment success/failure and applies the order "place"
transition **inside** the `computeHmac(...) == posted MAC` check; a mismatching MAC returns MAC-NOT-OK and
does not process the payment. So the public callback route (`/commerce_monetico/response`) is safe because
forged callbacks fail the HMAC check. When adopting: store the Monetico **security key** (and TPE number) as
secrets, operate over HTTPS, and keep the merchant key confidential (the HMAC's security rests on it).
Configure the Monetico credentials.

---

- Provide a Monetico payment gateway.
- Redirect customers to Monetico.
- Process the return/notification.
- Depend on Commerce Payment.
- VERIFY the Monetico HMAC-SHA1 seal.
- Recompute the MAC over return fields.
- Only accept payment when the MAC matches.
- Reject forged callbacks (MAC-NOT-OK).
- Store the Monetico security key as a secret.
- Operate over HTTPS.
- Keep the merchant key confidential.
- Handle Cybermut/CIC payments.
- Configure the Monetico credentials.
- Process payments securely.
- Confirm the HMAC check.
- Integrate Monetico.
- Handle the callback safely.
- Configure the gateway.
- Accept card payments.
