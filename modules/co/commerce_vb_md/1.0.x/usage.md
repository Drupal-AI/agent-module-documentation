<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce VictoriaBank Moldova integrates the VictoriaBank payment gateway (Moldova) with Drupal Commerce.

---

Commerce VictoriaBank Moldova provides Commerce integration for VictoriaBank — a payment gateway for Moldova — the shopper pays via VictoriaBank and the bank posts a signed callback.

Security: the callback verifies the bank's `P_SIGN` by RSA — `VictoriaBankSerializer::pSignDecrypt()` runs `openssl_public_decrypt()` with the bank's public key and compares the decrypted MAC (unforgeable without the bank's private key) — a correct, defensive pattern. The RSA key pair lives in the private filesystem (`private://vicb_pem/key.pem`, `private://vicb_pem/victoria_pub.pem`), outside the web root and never committed. Depends on `commerce_payment`; core `^8 || ^9 || ^10 || ^11`.

---

- Integrate the VictoriaBank gateway.
- Serve Moldova.
- Redirect/charge via the provider.
- Complete the order after payment.
- the callback verifies the bank's `P_SIGN` by RSA — `VictoriaBankSerializer::pSignDecrypt()` runs `openssl_public_decrypt()` with the bank's public key and compares the decrypted MAC (unforgeable without the bank's private key) — a correct, defensive pattern.
- Use Drupal Commerce payment.
- Keep the RSA key pair in the private filesystem (`private://vicb_pem/`).
- Never commit the keys or place them under the web root.
- Depend on `commerce_payment`.
- Support core `^8 || ^9 || ^10 || ^11`.
- Handle checkout.
- Process payments.
- Confirm the payment.
- Handle notifications.
- Support Commerce.
- Integrate VictoriaBank.
- Charge customers.
- Reconcile orders.
