# Configuration

Commerce Payin-Payout is configured as a Drupal Commerce **payment gateway**.

## Add the gateway

1. Go to **Store → Configuration → Payments → Payment Gateways** (that is,
   **Administration → Commerce → Configuration → Payment gateways**,
   `/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Payin-Payout** plugin.
3. Configure the settings:
   - **Mode** — **Test** or **Live**. This selects which Payin-Payout hosted
     endpoint is used (live `https://lk.payin-payout.net`, or the test host).
   - **API token** — your Payin-Payout token. It is used both to **sign** the
     outbound redirect and to **verify** inbound notifications, so it must be
     correct.
   - **Agent ID** — your store id at Payin-Payout.
   - **Agent name** — the store name shown to the buyer.
   - **Order ID prefix** — an optional label prefix shown to the buyer (for example
     `Order #`).
   - **Customer phone field** — the field on the **customer** profile that holds the
     phone number. This is required; the gateway throws an error at checkout if the
     selected field is missing from the billing profile.
   - **API logging** — optionally log request payloads to the
     `commerce_payin_payout` log channel for debugging.
4. Save, then attach the gateway to your **checkout flow**.

## How a payment is confirmed (and why it's safe)

The buyer is POST-redirected to Payin-Payout's hosted form to pay. Afterwards
Payin-Payout sends a **server-to-server notification** to the standard Commerce
notification URL. The module:

1. Checks that all expected notification fields are present, and ignores
   failed-status notifications.
2. Loads the order referenced by the notification.
3. **Recomputes the signature** over the notification fields (hashed with your API
   token) and compares it to the received `sign` using **`hash_equals()`**.
4. Only if the signature matches does it create a **completed** payment (using the
   notification's amount/currency) and reply with the expected XML acknowledgement
   so the gateway stops retrying.

Because fulfilment is gated behind the signature check, a **forged or unsigned
callback is rejected**. Be aware that the recorded amount/currency come from the
(signed) notification rather than an independent re-fetch — the signature is the
integrity guarantee — so keep your API token secret and treat any signature failures
in the logs as a red flag.

## Keep the API token safe

The API token is stored in **plain gateway configuration** — this module does not
use a Key entity. Restrict who can administer payment gateways and protect your
configuration exports. Prefer keeping the real value **out of version control**; with
DDEV you can store it as an environment variable:

```bash
ddev dotenv set .ddev/.env --payin-payout-token=<value>
ddev restart
```

(Never commit `.ddev/.env`.)
