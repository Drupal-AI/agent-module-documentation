<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates Ingenico ePayments (formerly Ogone) with Drupal Commerce, providing both an on-site DirectLink gateway and an off-site hosted e-Commerce gateway.

---
The module registers two Commerce payment gateway plugins. `DirectLink` (`ingenico_directlink`, on-site) collects card data on the merchant page and calls Ingenico's DirectLink API over Guzzle, optionally using the Alias Gateway to tokenise cards for reuse (no PAN stored locally). `ECommerce` (`ingenico_ecommerce`, off-site) redirects the shopper to Ingenico's hosted page via a signed POST form built in `ECommerceOffsiteForm`. Both share a `ConfigurationTrait` (PSPID, API user/password, SHA-IN / SHA-OUT passphrases, SHA algorithm, language, logging, 3-D Secure, white-label base URLs) and an `OperationsTrait` for capture / void / refund / authorization-renewal maintenance operations. 3-D Secure on DirectLink hands off to an e-Commerce gateway when authentication is requested.

Integrity rests on SHA signatures. Outbound requests are signed with the SHA-IN passphrase; inbound feedback is verified with the SHA-OUT passphrase. `ECommerce::processFeedback()` constructs an `EcommercePaymentResponse`, and if `isValid($shaComposer)` fails it marks the payment `failed` and throws `InvalidResponseException` — so both the browser return (`onReturn`) and the server-to-server notification (`onNotify`) reject any response whose `SHASign` does not match. Payment state is deliberately advanced only from the async notification. HTTP calls use a default Guzzle client (TLS verification on).

Typical setup: configure the Ingenico back office (SHA passphrases, feedback URLs, security options), add the payment gateway(s) at `admin/commerce/config/payment-gateways`, mirror the passphrases, choose live/test mode, and (for DirectLink 3-D Secure) point it at a defined e-Commerce gateway.
---
- Accept credit-card payments through Ingenico/Ogone in Drupal Commerce.
- Offer an off-site hosted payment page (e-Commerce gateway).
- Offer on-site card entry via the DirectLink gateway.
- Tokenise cards with the Alias Gateway for repeat purchases.
- Enable 3-D Secure cardholder authentication.
- Support Authorize-only then capture-later transaction mode.
- Void an authorization before capture.
- Capture a previously authorized payment.
- Refund a captured payment from the order admin.
- Renew an expiring authorization.
- Verify inbound SHA-OUT signatures on payment feedback.
- Sign outbound requests with the SHA-IN passphrase.
- Configure SHA-1 / SHA-256 / SHA-512 hashing to match Ingenico.
- Run against Ingenico test then switch to live mode.
- Use a white-label clone (e.g. BarclayCard/ePDQ) via custom base URLs.
- Render the hosted page in the merchant-selected language.
- Log API request/response messages for debugging.
- Receive server-to-server notifications to finalise payment state.
- Handle decline responses with a DeclineException and NCERROR code.
- Configure PSPID and dedicated API user credentials.