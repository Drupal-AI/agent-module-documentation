<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce CCAvenue (commerce_ccavenue) — agent index
**Off-site Commerce payment gateway redirecting to CCAvenue with AES-128-CBC encrypted request/response.**

- **Version:** 4.0.x
- **Core:** ^10.1 || ^11
- **Depends on:** `commerce:commerce_payment`
- **Gateway:** `@CommercePaymentGateway(id="ccavenue_redirect")` (`OffsitePaymentGatewayBase`); offsite form `PaymentCCAvenueForm`; crypto in `CCAvenueEncryption` (AES-128-CBC, MD5-derived key, fixed IV).
- **Config:** per gateway at `entity.commerce_payment_gateway.collection` (Merchant ID, Access Code, Working Key, currency, mode).
- **Return:** standard `commerce_payment.checkout.return/cancel` (checkout-access gated). Charged amount always from the server-side order total.
- **Security (observations, reviewed):** response authenticity relies on decrypting `encResp` with the shared working key (no separate signature); `onReturn()` (`CCAvenueRedirect.php` ~L148-176) does not cross-check the decrypted `order_id`/`amount` against the current order; TEST and LIVE URLs are identical (`PaymentCCAvenueForm.php` L14-15, both point to production `secure.ccavenue.ae`). No client-set amount, no disabled TLS in code.

See [configure/gateway.md](configure/gateway.md)
