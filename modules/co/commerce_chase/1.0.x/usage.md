<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds a Drupal Commerce payment gateway that takes card payments through Chase Orbital / Paymentech, collecting the card in Chase's hosted (tokenizing) iframe and charging it server-side over the Orbital SOAP API.

---

Commerce Chase provides an onsite Drupal Commerce payment gateway (plugin id `chase_hpf`, "Orbital® Hosted Payment Form") for merchants whose processor is Chase Orbital / Paymentech. During checkout the customer's card fields are rendered by Chase's Hosted Payment Form inside an `<iframe>` served from Chase's own domain; the form tokenizes the card (`hosted_tokenize=store_only`) and returns a token (customer reference number) plus a masked card number, so the raw card number and CVV are entered on Chase's page rather than posted to the Drupal server. The gateway then drives the transaction server-side against the Orbital SOAP gateway: it authorizes and optionally captures the charge (`NewOrder`), and supports separate capture (`MarkForCapture`), void (`Reversal`), stored-profile fetch/delete, and a cron job that removes remote profiles for one-off (non-reusable) cards. The gateway is configured through Commerce's normal payment-gateway UI, where you enter your Secure Account ID, Orbital API username and password, Terminal ID, Merchant ID and BIN, and choose test or live mode. It depends on Commerce Payment and runs on Drupal 9.3, 10 and 11. The installed release is an alpha and the project is minimally maintained, so pin the version and test end-to-end against Chase's test environment before going live.

---

- Take card payments in Drupal Commerce through Chase Orbital / Paymentech.
- Render Chase's Hosted Payment Form in an iframe so card entry happens on Chase's domain.
- Tokenize the card at Chase (store-only) and keep the raw PAN/CVV off the Drupal server.
- Store a Commerce payment method holding the token, masked card number and expiry.
- Authorize and capture in one step, or authorize now and capture later.
- Capture a prior authorization (optionally for a partial amount).
- Void / reverse an authorization.
- Delete a stored Orbital profile when a payment method is removed.
- Garbage-collect remote profiles for non-reusable cards via cron.
- Charge the server-side order amount (converted to minor units), never a browser-supplied amount.
- Send AVS data (billing address) with the charge.
- Switch between Chase test (`-var` / `wsvar1`) and live (`ws1`) endpoints via the gateway mode.
- Choose the processing BIN (Stratus `000001` or PNS `000002`).
- Limit which card brands are offered on the form.
- Require a minimum set of card fields, or make all card fields mandatory.
- Let other modules alter the hosted-form iframe element and its URL query via events.
- Map Chase card-type labels to Commerce credit-card types.
- Support reusable stored cards for returning customers.
- Configure the gateway from Commerce → Configuration → Payment gateways.
- Depend on Commerce Payment (`commerce_payment`).
- Support Drupal 9.3, 10 and 11.
