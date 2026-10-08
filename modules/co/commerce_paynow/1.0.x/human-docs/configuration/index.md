# Configuration

Commerce Paynow is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Paynow** plugin.
3. Enter your Paynow integration details:
   - **API Key** — your Paynow API key.
   - **Signature Key** — your Paynow signature key, used to verify the webhook
     signature. It must be correct or valid notifications will be rejected.
   - **Logging** — optionally enable logging for debugging.
4. Save, then attach the gateway to your **checkout flow**.

## How a payment is confirmed

Customers select Paynow at checkout and pay via the provider. Paynow then posts a
**webhook notification** to your site, and the module updates the payment status
automatically. Before it changes anything, the module builds the Paynow SDK's
notification object from your **signature key**, the payload, and the request
headers; the SDK **verifies the `Signature` header (HMAC) and throws on a mismatch**.
A forged or unsigned notification is therefore rejected before the payment state is
touched.

## Keep your credentials safe

Store the Paynow **API Key** and **Signature Key** securely and **env-backed** —
never commit them to version control. With DDEV you can store a secret as an
environment variable and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --paynow-signature-key=<value>
ddev restart
```

(Never commit `.ddev/.env`.) Restrict who can administer payment gateways and protect
your configuration exports.
