<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Paytrail integrates Paytrail payments with Drupal Commerce.

---

Commerce Paytrail integrates Paytrail — a Finnish payment service — with Drupal Commerce, providing a
payment gateway (token/redirect flow) so a store can accept Paytrail payments. It depends on Drupal Commerce,
in the Commerce (contrib) package.

Use it to accept Paytrail payments. Its security handling is **correct**: the payment return/notify handler
**validates the Paytrail HMAC signature** on the callback — `validateSignature($this->getSecret(),
$request->query->all())` using the Paytrail SDK's `Signature::calculateHmac` (a `SignatureTrait` creates and
validates signatures) — so a forged callback with a bad signature is rejected. When adopting: store the
Paytrail **merchant secret as a secret** (it keys the HMAC), operate over HTTPS, and confirm the account
mode. Configure the Paytrail credentials.

---

- Provide a Paytrail payment gateway.
- Accept Paytrail payments.
- Use the token/redirect flow.
- Depend on Drupal Commerce.
- VALIDATE the Paytrail HMAC signature on callbacks.
- Use the Paytrail SDK Signature.
- Reject forged callbacks (bad signature).
- Store the Paytrail merchant secret as a secret.
- Operate over HTTPS.
- Confirm the account mode.
- Have no access-control role.
- Configure the Paytrail credentials.
- Handle Paytrail payments.
- Verify the callback signature.
- Configure the gateway.
- Handle credentials securely.
- Integrate Paytrail.
- Process payments securely.
- Confirm the HMAC check.
- Accept Finnish payments.
