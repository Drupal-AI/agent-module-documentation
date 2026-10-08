# Configuration

Commerce Wise is configured as a Drupal Commerce payment gateway. You provide your
Wise business @tag and Wise's webhook public key, choose the mode, then register a
webhook in your Wise account. See the module's README for Wise Quick Pay's exact
steps.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, name it (for example "Wise"), and choose
   **Wise Quick Pay** as the plugin.

## Gateway settings

- **Wise tag** — your Wise business account @tag, used to build the Quick Pay payment
  link the shopper is redirected to. Found in Wise under **Security & Privacy →
  Contacts discoverability** (create one if you have none).
- **Public Key** — the public key Wise uses to sign webhook notifications. The module
  validates every incoming webhook's `X-Signature-SHA256` header against this key.
  Copy the **sandbox** or **production** key (matching the gateway mode) from Wise's
  event-handling docs:
  `https://docs.wise.com/api-docs/webhooks-notifications/event-handling#requests`.
- **Account type** — currently only **Business** is available.
- **Log webhook events** — when enabled, incoming webhook bodies are written to the
  Drupal log (`commerce_wise` channel). Leave off in production unless debugging.
- **Mode** — the standard Commerce test/production switch. It selects the Wise host
  the shopper is sent to (`https://wise.com` for live,
  `https://sandbox.transferwise.tech` for test), so it must match the public key you
  pasted.

There is **no API token** field — Commerce Wise does not call Wise's REST API; it only
redirects the shopper to a Quick Pay link and receives signed webhooks.

## Set up the webhook

In your Wise business account:

1. Go to **Integration & Tools → Webhooks**.
2. Create a new webhook of type **Account deposit events**.
3. Give it any name.
4. Set the URL to
   `https://yourwebsite.com/payment/notify/<machine_name_payment_gateway>`, replacing
   `<machine_name_payment_gateway>` with the machine name of the gateway you created in
   Drupal.

When a verified deposit notification arrives, the module matches the transfer
reference to the corresponding local order and records the payment, moving the order
to placed.

## Save and test

Click **Save**, then run a test transaction and confirm a webhook from Wise records
the payment against the right order before going live. Always serve the site over
**HTTPS**.
