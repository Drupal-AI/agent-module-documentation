# Configuration

Commerce Paymob is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose a plugin:
   - **Paymob Redirect** (`paymob_redirect`) — offsite; the customer pays on Paymob
     and is redirected back.
   - **Paymob Pixel** (`paymob_pixel`) — onsite tokenized payment; supports reusable
     stored cards.
3. Fill in the settings:
   - **Server** — the region base URL: **Egypt**, **Oman**, **Saudi Arabia**, or
     **UAE** (all HTTPS).
   - **Public Key**, **Secret Key**, **Api Key** — your Paymob credentials. The
     secret key is used as the bearer token for API calls.
   - **Payment Integration** — one or more Paymob integration IDs (comma-separated).
   - **HMAC** — your Paymob HMAC secret, used to verify callbacks. **Required.**
   - **Customer profile telephone field** — the profile field that supplies the
     customer's phone number.
   - **Allow reusing payment method** — enables stored card tokens (Pixel flow).
4. Save, then attach the gateway to your **checkout flow**.

## How a payment is confirmed (and why it's safe)

- The module builds a payment **intention** with the order total (in minor units),
  billing data, and a notification URL, and sends it to Paymob over HTTPS.
- On the customer **return**, and on the server-to-server **webhook**, the response
  is **verified with your HMAC secret before any payment state transition**. A
  bad or absent signature throws a payment exception — an unsigned or forged callback
  cannot fulfil an order.
- The **Pixel** flow additionally re-checks that the charged amount equals the
  expected amount before completing.
- The webhook can also fulfil the order if the return handler was missed, and for
  tokenized payments it briefly caches the token payload to build a stored payment
  method. Only card **tokens** (plus last-4 and card subtype) are stored, never full
  card numbers.
- Refunds (full or partial) are supported via Paymob's void/refund endpoint.

## Keep your credentials safe

The **secret key, API key, and HMAC secret** are stored as **plain gateway
configuration**. Restrict who can administer payment gateways, and protect your
configuration exports and access. Prefer keeping the real values **out of version
control**; with DDEV you can store a secret as an environment variable:

```bash
ddev dotenv set .ddev/.env --paymob-secret-key=<value>
ddev restart
```

(Never commit `.ddev/.env`.)
