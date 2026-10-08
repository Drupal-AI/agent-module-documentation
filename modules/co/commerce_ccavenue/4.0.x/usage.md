<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Commerce CCAvenue provides an off-site redirect payment gateway that sends shoppers to CCAvenue with an AES-128-CBC encrypted request and decrypts the encrypted response on return.
---
The gateway plugin (`src/Plugin/Commerce/PaymentGateway/CCAvenueRedirect.php`, id `ccavenue_redirect`) extends `OffsitePaymentGatewayBase`. `PaymentCCAvenueForm` builds the merchant parameter set — order id, `amount` taken from the server-side order/payment (`round($payment->getAmount()->getNumber(), 2)`), currency, billing fields and Drupal-generated `redirect_url`/`cancel_url` — concatenates them, AES-encrypts with the working key (`CCAvenueEncryption::encrypt`) and auto-POSTs to CCAvenue. On return, `onReturn()` decrypts `encResp` with the working key, parses the `&`-joined fields, reads the order status (position index 3), and on `Success` creates a `commerce_payment` in the `authorization` state using the order's own total. The return/cancel URLs are the standard `commerce_payment.checkout.*` routes (checkout-access gated).

Configuration is per payment gateway (Merchant ID, Access Code, Working Key, currency) at the payment-gateway collection; credentials are stored in gateway config. Encryption uses AES-128-CBC with a fixed all-zero-through-0x0f IV and an MD5-derived key (matching CCAvenue's published integration), so response authenticity rests on the shared working key rather than a separate signature. Setup: create a "CCAvenue Redirect" gateway, enter the CCAvenue credentials, pick the currency, and set live/test mode.

Operational/security notes (observations only): (1) both `CCAVENUE_API_TEST_URL` and `CCAVENUE_API_URL` point at the same production `secure.ccavenue.ae` endpoint, so "test" mode still hits production. (2) `onReturn()` trusts the decrypted status string and marks the current order authorized using the order's total without cross-checking the decrypted `order_id`/`amount`, so a captured valid `Success` response cannot be forged (no working key) but is not bound to a specific order in code. Amount is always taken server-side, never from the response.
---
- Accept CCAvenue card payments in Drupal Commerce.
- Redirect shoppers off-site to the CCAvenue hosted page.
- Encrypt the request with the merchant working key.
- Decrypt and read the CCAvenue response on return.
- Support INR, USD, SGD, GBP and EUR currencies.
- Configure Merchant ID / Access Code / Working Key per gateway.
- Switch between test and live modes.
- Create an authorization payment on success.
- Show aborted/declined messages to the shopper.
- Use standard Commerce return/cancel checkout routes.
- Pass billing name/address to CCAvenue.
- Derive the charged amount from the order total.
- Integrate with the Commerce checkout flow.
- Store gateway credentials in configuration.
- Handle the CCAvenue AES-128-CBC encryption scheme.
- Set the default display label for the gateway.
- Provide a credit-card off-site payment method.
- Route customers back to complete checkout.
- Log/notify success via the messenger.
- Deploy for India/UAE CCAvenue merchant accounts.
