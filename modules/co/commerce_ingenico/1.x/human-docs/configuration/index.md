# Configuration

Ingenico is configured in two places that must agree with each other: the
**Ingenico back office** and the Drupal **payment gateway**. The SHA passphrases
and feedback URLs you set in the back office have to be mirrored exactly in Drupal,
or signature verification will fail.

## 1. Configure the Ingenico back office

In your Ingenico/Ogone account:

- **Global security:** set the hashing to **SHA-512** and encoding to **UTF-8**
  (SHA-512 is recommended; whatever you pick must match the module).
- **Data and origin verification:** set the **SHA-IN** passphrase (use the same
  value for the e-Commerce/Alias and DirectLink/Batch sections).
- **Transaction feedback:** enable the feedback parameters on the redirect URLs,
  set the server-to-server post URL to
  `https://yoursite/payment/notify/<PARAMVAR>` with request method **GET**, and set
  the **SHA-OUT** passphrase.
- Create a dedicated **API user** (a "special user for API") for the module to
  authenticate with.

## 2. Add the gateway in Drupal

1. Log in as a user who can **administer commerce payment gateways**.
2. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
3. Select the plugin you want — **Ingenico DirectLink** (on-site) or **Ingenico
   e-Commerce** (off-site). You can add both.
4. Fill in the fields:
   - **PSPID** — your Ingenico account ID.
   - **User ID** and **Password** — the dedicated API user credentials.
   - **SHA algorithm** — must match the back office (SHA-1 / SHA-256 / SHA-512).
   - **SHA-IN** and **SHA-OUT** — the passphrases; must match the back office
     **exactly**.
   - **Language** — the language for the hosted pages / 3-D Secure.
   - **API logging** — enable request/response logging for debugging if needed.
   - **3-D Secure** (DirectLink only) — enable it and select the e-Commerce gateway
     to hand off to. A `ingenico_ecommerce` gateway must already exist for this.
   - **White-label base URL** (test/live) — only for Ingenico clones such as
     ePDQ / BarclayCard; it rewrites the default `https://secure.ogone.com/` host.
   - **Mode** — test vs live (this selects the API URL).

## 3. Set the transaction mode

Choose **Authorize-and-capture** vs **Authorize-only** on the checkout flow at
**Commerce → Configuration → Checkout flows**
(`/admin/commerce/config/checkout-flows`). Authorize-only lets you capture the
payment later, which can help avoid refunds.

## Store credentials securely

The API user password and the SHA-IN / SHA-OUT passphrases are secrets — keep them
out of version control. Store each value in an environment variable and reference it
through a **Key** entity where the module supports one:

```bash
ddev dotenv set .ddev/.env --ingenico-api-password=<your-password>
ddev restart
```

If the [Key module](https://www.drupal.org/project/key) is not enabled yet, add it
with `ddev composer require drupal/key && ddev drush en key -y`, then create a Key
that reads the environment variable.

## Maintenance operations

Once live, you can perform **capture**, **void**, **refund** (full or partial) and
**authorization renewal** from the payment admin UI. An automated capture process
can also run via cron (and be triggered manually from
`/admin/commerce/orders/batch`) to capture the previous day's authorized
transactions.

## How payments are verified (why this is safe)

Integrity rests on SHA signatures. Outbound requests are signed with the **SHA-IN**
passphrase; inbound feedback is verified with the **SHA-OUT** passphrase. If a
response's signature does not match, the module marks the payment **failed** and
throws — this applies to both the browser return and the server-to-server
notification. Crucially, payment state is advanced only from the **async
notification**, not the browser return, and all API calls use TLS verification. So
as long as your passphrases match the back office exactly, forged or tampered
responses are rejected — there is nothing extra to harden beyond keeping the
passphrases and API password confidential.
