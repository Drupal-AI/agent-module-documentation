# Configuration

Setting up eSewa is a two‑part job: make sure your store uses **NPR**, then add and
configure the **eSewa payment gateway**. eSewa only processes Nepalese Rupees, so
the currency step is not optional — the module refuses to build the payment form if
the order currency is not NPR.

## Step 1 — Set your store currency to NPR

1. Go to **Commerce → Configuration → Currencies** and confirm **Nepalese Rupee
   (NPR)** is present. If it is not, click **+ Add currency** and add it.
2. Go to **Commerce → Configuration → Stores**, edit your store, and set **NPR** as
   the default currency.

## Step 2 — Add the eSewa payment gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
2. Click **+ Add payment gateway**.
3. In the **Plugin** dropdown, select **eSewa**.
4. Fill in the fields (see below), then click **Save**.

## Gateway fields

- **Name** — a label for this gateway (shown to you in the admin list; the
  customer‑facing display name is configured with it).
- **Mode** — choose **Test** or **Live**.
  - **Test** uses eSewa's sandbox automatically — no credentials required, which is
    ideal for trying checkout end to end.
  - **Live** requires your real eSewa merchant/product code and secret key. The form
    validates that live credentials are present when the mode is set to Live.
- **eSewa merchant / product code and secret key** — your live eSewa credentials,
  used to sign the outgoing request and to verify the signed response. These are
  entered on the gateway form.

Set the mode to **Live** and enter your production credentials only when you are
ready to take real payments; keep it on **Test** while you validate the flow.

## Storing your eSewa credentials safely

Your live secret key is a sensitive credential — treat it like a password. Rather
than typing secrets straight into configuration that might be exported or committed,
keep the value in an environment variable and reference it.

With DDEV, save the secret into the project's dotenv file (never commit
`.ddev/.env`) and restart so the container picks it up:

```bash
ddev dotenv set .ddev/.env --esewa-secret-key=<your-live-secret>
ddev restart
```

The flag `--esewa-secret-key` becomes the environment variable
`ESEWA_SECRET_KEY` inside the web container. You can then reference that variable
when configuring the gateway (for example via a Key entity using the **env**
provider if you manage credentials with the **Key** module, or from settings), so
the secret itself is not stored in exported configuration.

## How the return trip is secured (good to know)

After the customer pays, eSewa redirects their browser back to `/esewa/success`
(or `/esewa/cancel`). Those callback routes are necessarily open to unauthenticated
requests — eSewa is redirecting an ordinary browser — but the success handler
records **no** payment until it has:

1. verified the **HMAC‑SHA256** signature on the returned payload via the SDK;
2. matched the transaction UUID against the one stored in the session (replay
   protection);
3. confirmed the status is `COMPLETE`; and
4. confirmed the returned amount matches the stored order total (±0.01).

So the open callback cannot be used to forge a completed order. This is a sound
posture — but keep your secret key confidential, because the signature verification
depends on it.

## Save and test

Click **Save**, then run a test order in **Test** mode: add an NPR product to the
cart, choose eSewa at checkout, complete the sandbox payment, and confirm you are
returned to your site with the order marked paid. Switch to **Live** with real
credentials only after the sandbox flow works end to end.
