<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce Banca Intesa provides Drupal Commerce integration with Banca Intesa Serbia's payment services.

---

Commerce Banca Intesa provides a **Drupal Commerce offsite-redirect payment gateway** for **Banca Intesa
Serbia** (NestPay/Payten, the `eway2pay` platform) — the customer is redirected to the bank to pay and returned
to the site, where the module validates the result and records the payment. It depends on Commerce (Order and
Payment) and on `gnikolovski/gnikolovski_payment_log`, which Composer pulls in automatically.

Use it to accept Banca Intesa Serbia card payments. On checkout the offsite form auto-POSTs a signed request to
the bank's 3-D-secure hosted page. On return, `onReturn()` verifies the transaction: it checks the returned
order ID against the order, checks the merchant/client ID against config, verifies the bank's **digital
signature** via `isHashValid()` (recomputes `base64(sha512(fields . store_key))` and rejects on mismatch —
forging a valid `HASH` requires the shared **store_key** secret), and requires `ProcReturnCode == '00'`. Only
then does it create a **completed** payment for **`$order->getBalance()`** (the site's own order total, taken
from the order, not from the request). A `hook_cron` job also reconciles any pending orders by querying the
bank server-to-server (an authenticated CC5Request `ORDERSTATUS QUERY`) and finalising the order if the bank
reports it approved.

Configure it by adding a payment gateway and selecting the **Banca Intesa** plugin, then entering the
bank-issued merchant ID, username, password and store key and choosing Test or Live mode. Keep the **store
key** and **password** secret and always run the site over HTTPS. The module's `hook_requirements` will warn if
`session.cookie_samesite` is not set to `None`, which the POST-based return needs so the browser sends the
session cookie back with the bank's response.

---

- Provide a Banca Intesa Serbia (NestPay) offsite-redirect gateway.
- Redirect the customer to the bank's 3-D-secure page.
- Auto-POST a signed request to the bank.
- Verify the bank's digital signature on return.
- Recompute the HASH with the store_key secret.
- Check the returned order ID and merchant ID.
- Require ProcReturnCode == 00.
- Record the payment for the server-side order total.
- Reconcile pending orders via an authenticated cron query.
- Send a payment-report email on success/fail (optional).
- Show a payment-report table (optional).
- Store the store_key and password as secrets.
- Use HTTPS; set session.cookie_samesite to None.
- Depend on Commerce Order/Payment and gnikolovski_payment_log.
- Configure the gateway credentials and mode.
- Accept card payments.
- Handle the return and cancel legs.
- Process payments.
