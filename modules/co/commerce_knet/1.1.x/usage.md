<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce KNET integrates the KNET payment gateway (Kuwait) with Drupal Commerce.

---

Commerce KNET provides Commerce integration for KNET — Kuwait's national debit-card network. It is an off-site redirect gateway: the shopper is redirected (browser GET) to the KNET hosted payment page, and KNET returns with an AES-128-CBC-encrypted `trandata` response.

How the return is handled: the return controller decrypts the KNET `trandata` with the merchant's terminal resource key, then checks the outcome server-side — the result must be `CAPTURED`, the returned order id (`udf3`) must equal the order in the URL, and the returned amount (`amt`) must equal the order's own total (`$order->getTotalPrice()`) — before recording a completed payment with the order's currency. Store the KNET credentials (`tranportal_password`, `terminal_resource_key`) securely; the README recommends overriding live values in `settings.php` rather than the database. Serve the callback over HTTPS. Depends on `commerce_payment`.

Compatibility caveat: the bundled `SecureText` helper uses PHP-7-only curly-brace string-offset syntax (`$text{…}`), a parse error on PHP 8.0+. Because Drupal 10/11 require PHP 8, the encrypt (checkout redirect) and decrypt (return) paths fatal on those cores until the line is patched to `$text[…]`.

---

- Integrate the KNET gateway.
- Serve Kuwait.
- Redirect the shopper to the KNET hosted page to pay.
- Complete the order after payment.
- On return, decrypt the KNET `trandata` with the terminal resource key and check `result`, order id (`udf3`) and amount server-side before recording a completed payment.
- Use Drupal Commerce payment.
- Store credentials securely (env-backed).
- Never commit credentials.
- Depend on `commerce_payment`.
- Support ^10 || ^11.
- Handle checkout.
- Process payments.
- Confirm the payment.
- Handle notifications.
- Support Commerce.
- Integrate KNET.
- Charge customers.
- Reconcile orders.
