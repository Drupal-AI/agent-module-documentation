# Configuration

CCAvenue is configured like any Commerce payment gateway: add a gateway and enter
your CCAvenue merchant credentials.

## Store your Working Key securely

The **Working Key** is the secret that encrypts your requests and decrypts
CCAvenue's responses — and, because there is no separate signature, it is the *only*
thing that makes a response trustworthy. Treat it as a high‑value secret. On a DDEV
site, keep it in an environment variable rather than hard‑coding it:

```bash
ddev dotenv set .ddev/.env --ccavenue-working-key=<value>
ddev restart
```

(`.ddev/.env` must stay out of version control.) Reference it through a **Key**
entity where practical, and apply the same care to the Access Code.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the **CCAvenue Redirect** plugin.
3. Enter your CCAvenue credentials:
   - **Merchant ID**
   - **Access Code**
   - **Working Key** (keep this confidential — see above)
   - **Default Currency** — one of INR, USD, SGD, GBP, or EUR.
4. Choose the **mode** (test/live) — but read the note below about what that
   actually does.
5. Save.

## How a payment flows

- On checkout, the gateway builds the parameters (order id, **amount from the
  server‑side order total**, currency, billing, and Drupal‑generated redirect/
  cancel URLs), AES‑128‑CBC encrypts them with your working key, and auto‑POSTs the
  shopper to CCAvenue's hosted page.
- On return, the module decrypts CCAvenue's `encResp` with the working key, reads
  the status, and on **Success** creates a Commerce payment in the *authorization*
  state using the **order's own total**. Cancels show a resumable‑checkout message.

## Operational and security notes to respect

These are observations from the module's code that you should factor into how you
run it — none of them require code changes on your part, but they shape safe use:

- **Test mode still hits production.** Both the "test" and "live" endpoints point
  at the same production CCAvenue host (`secure.ccavenue.ae`). A transaction in
  test mode is a real transaction against production, so use test cards/accounts
  and small amounts, and don't assume "test" is a sandbox.
- **Authenticity rests on the Working Key alone.** There is no separate checksum or
  signature beyond successfully decrypting the response with your working key.
  Because an attacker can't produce a valid `Success` response without that key, a
  forged response isn't feasible — *provided the key stays secret*. This is why
  protecting the Working Key matters so much.
- **The response isn't bound to a specific order in code.** The charged amount is
  always taken from the order server‑side (never from the response), but the module
  does not cross‑check the decrypted `order_id`/`amount` from CCAvenue against the
  current order. Keep this in mind when reconciling payments, and verify order
  totals against CCAvenue's own dashboard.
- **Serve checkout over HTTPS** and keep the module updated (the project is in
  maintenance‑fixes mode and seeking a co‑maintainer).
