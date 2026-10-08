<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Cybersource REST (Microform) is a Drupal Commerce payment gateway that captures card data in Cybersource-hosted Flex Microform v2 iframes and charges it server-side over the Cybersource REST API.
---
The PAN and CVV are entered into Cybersource-hosted Microform iframes, so raw card data never touches the Drupal server (keeping the site out of most PCI scope); the browser receives an opaque transient token that the site sends to Cybersource to authorize and capture the payment. Requests are authenticated with Cybersource HTTP Signature (merchant id + key id + shared secret) via the official `cybersource/flex-microform` / rest SDK against the fixed test/live API hosts, so TLS and signing are handled by the SDK — there is no `verify => false`. API credentials are read from an external private `.yml` file by `CredentialProvider`, never stored in site config or the database.

The gateway supports optional 3-D Secure / Payer Authentication: three session-authenticated POST routes (setup, enroll, challenge return) drive the device-data-collection and challenge flow. The `PayerAuthController::access` check requires that the caller owns the (draft) order — via the anonymous cart session or the authenticated customer id — that the gateway is an enabled cybersource_rest gateway with 3-D Secure on, and a valid CSRF header token. The authoritative charge amount and currency always come from the order (`$order->getTotalPrice()`) / payment entity, never from client input. Set up the gateway by placing the credentials `.yml`, adding a Cybersource REST payment gateway in Commerce, and (optionally) enabling Payer Authentication.
---
- Add a Cybersource REST payment gateway to a Drupal Commerce store
- Accept credit-card payments captured in Cybersource Microform iframes
- Keep the site out of PCI scope by never handling raw PAN/CVV
- Store API credentials in an external private .yml outside site config
- Authenticate API calls with Cybersource HTTP Signature (key id + shared secret)
- Switch between Cybersource test and live hosts per gateway mode
- Authorize and capture a payment in one step at checkout
- Authorize now and capture the payment later from the order screen
- Void an uncaptured authorization
- Refund a captured payment in full or partially
- Enable 3-D Secure / Payer Authentication for card-not-present fraud reduction
- Run device data collection (setup) before the payment request
- Enroll an order in a 3-D Secure challenge and handle the ACS challenge return
- Log every gateway request/response through commerce_log templates
- Show a credentials-status warning in the admin UI when the .yml is missing
- Charge the authoritative order total rather than any client-supplied amount
- Review payment transaction ids and remote states on the order
- Configure accepted card types shown on the payment form
- Test the integration in the Cybersource sandbox before going live
