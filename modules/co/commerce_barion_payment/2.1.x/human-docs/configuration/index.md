# Configuration

Commerce Barion Payment is configured as a Commerce payment gateway; there is no
separate settings page.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name**, and under **Plugin** choose **Barion**.

## Fields to fill in

These are the exact fields the gateway form presents (from
`BarionPaymentGateway::buildConfigurationForm()`):

- **Barion email address** — the e‑mail (Payee) of your Barion account. Required.
- **Secret key (POSKey)** — the secret key issued by Barion. The module uses this
  to authenticate every server‑to‑server API call (including `GetPaymentState`).
  Treat it as a payment secret (see below). Required.
- **API version number** — the Barion API version to call. Defaults to `2`.
- **Payment Window (HMS)** — how long the customer has to complete the payment,
  entered as three two‑digit boxes (hours : minutes : seconds). Defaults to
  `00:05:00`. Each box must be exactly two digits (pad with a leading zero).
- **Barion locale (language also)** — the language/locale Barion shows on its
  hosted payment page. Defaults to English.
- **Reservation period** — for authorize‑only (reservation) checkouts, how long
  the reservation is held, in `d.hh:mm:ss` format (between 1 minute and 1 year).
  Defaults to `0.00:30:00` (30 minutes). Ignored when the checkout captures
  immediately.
- **Mode (Test / Live)** — the standard Commerce gateway mode selector. Barion
  provides a sandbox test environment and a live one; the module maps the mode to
  Barion's `Test` / `Prod` environment. Start in **Test** while validating, then
  switch to **Live** for real payments. Make sure the Secret key you enter matches
  the environment you select.

Whether Barion is asked to capture immediately or only reserve funds is not a
field here — it follows your checkout flow's **payment_process → capture**
setting. When capture is off the payment is created as a reservation and can be
captured or voided later from the order's payments tab.

## Keeping the Secret key safe

The Secret key (POSKey) is a payment secret. This gateway stores it in its own
payment‑gateway configuration entity (it does not integrate the Key module), so
the value lives in configuration: keep configuration exports out of any public
repository, restrict who holds the *administer payment gateways* permission, and
always serve the admin over HTTPS.

## Save and test

1. Set the environment to **Test** and save.
2. Place a test order and pay through Barion, then confirm the order is marked
   paid once Barion reports success.
3. Switch to **Live** only after the test flow works end‑to‑end.

## Security notes

- Payment confirmation is **API‑verified**: on notification the module fetches
  the authoritative state from Barion (`GetPaymentState`) using your Secret key
  rather than trusting the notification payload, so a forged notification cannot
  mark an order paid.
- Keep the **Secret key (POSKey)** secret, and always run the site over
  **HTTPS**.
