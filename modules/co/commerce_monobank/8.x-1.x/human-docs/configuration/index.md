# Configuration

Configuring Commerce Monobank means registering for acquiring, then adding a
gateway with your merchant token.

## Add the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**.
4. Give it a **Name** and choose the **Monobank** plugin.

## The settings, field by field

- **X-Token** — your Monobank merchant token, obtained when you register for
  acquiring. The module sends this token when creating invoices and querying
  Monobank's status API.
- **Validity time** — how long a created invoice stays valid, in seconds
  (minimum 60; Monobank defaults to 24 hours). For example, `3600` for one hour.
- **Payment Type** — `debit` (immediate charge) or `hold` (authorise now, capture
  later).
- **Action url** — the Monobank API base URL used in **Live** mode, normally
  `https://api.monobank.ua/`. (In **Test** mode the module uses
  `https://api.monobank.ua/` automatically.)
- **Test / Live** — flip this switch to choose the environment; it works
  automatically. Use **Test** while integrating and **Live** for real payments.

Save the gateway. Behind the scenes, the module stores each order's Monobank
invoice ID and uses it to fetch the payment status.

## Handle the X-Token safely (important)

Note that **this release stores the X-Token in the module's configuration**, not
via Drupal's Key module. That has two practical consequences you should manage:

- **Restrict who can view or edit the payment-gateway configuration**, since the
  token lives there. Only trusted administrators should have that access.
- **Keep the token out of exported/committed configuration.** If you export
  configuration to code (and commit it), make sure the token value is not carried
  along — exclude it or override it per environment. As a general practice, keep
  the secret in an environment variable and set it out of band. With DDEV you can
  store it with the built-in dotenv command:

  ```bash
  ddev dotenv set .ddev/.env --monobank-x-token='<your X-Token>'
  ddev restart
  ```

  Keep `.ddev/.env` out of version control.
- Always serve checkout over **HTTPS**.

## How the payment is confirmed (why it's safe)

Commerce Monobank does not rely on an unverified callback to mark an order paid.
Instead it queries Monobank's **server-side status API**
(`api/merchant/invoice/status?invoiceId=…`) with your merchant token and completes
the payment based on the invoice's real, authoritative state. Because this is an
**alpha** release, verify this flow end to end for your version before relying on
it in production.

## Test before going live

With the **Test** switch on, run a full checkout and confirm the payment records
against the order. Switch to **Live** only once the test flow works cleanly.
