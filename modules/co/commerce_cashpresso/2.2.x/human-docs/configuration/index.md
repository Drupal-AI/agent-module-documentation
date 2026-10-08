# Configuration

cashpresso is configured like any Commerce payment gateway: you add a gateway and
fill in your cashpresso credentials and financing options.

## Store your API secret securely

The gateway needs a cashpresso **API key** and a **shared secret**. Treat the
secret as sensitive — don't paste it into a settings file that ends up in version
control. The recommended pattern on a DDEV site is to keep it in an environment
variable and, where supported, reference it through a **Key** entity:

```bash
ddev dotenv set .ddev/.env --cashpresso-secret=<value>
ddev restart
```

(`.ddev/.env` must stay out of version control.) You can then create a Key entity
backed by that environment variable and reference it, or otherwise avoid hard‑
coding the secret. Do the same for the API key if you prefer to keep it out of
config.

## Add the gateway

1. Go to **Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Give it a name and display label, and choose the **cashpresso** plugin.
3. Fill in the configuration fields:
   - **API key** — your cashpresso partner API key.
   - **Secret** — the shared secret used to compute and verify every verification
     hash. Keep this confidential (see above).
   - **Order valid time** — how many hours an authorised‑but‑incomplete payment
     stays valid (default 168).
   - **Merchant interest‑free days** — extra interest‑free days you choose to
     grant; this is validated against your partner limit via a live cashpresso
     `partnerInfo` call, so it can't exceed what your account allows.
4. Choose the **mode** — **Test** (talks to `backend.test-cashpresso.com`) or
   **Live** (talks to `rest.cashpresso.com`). Always start in test.
5. Save.

The config form also fetches and displays your partner‑account info (status,
limits, rates) so you can confirm the credentials are correct.

## How payment is confirmed (and why it's safe)

- At checkout the gateway POSTs the order amount, basket, and addresses to
  cashpresso, with the **charged amount taken from the order** (`$payment->
  getAmount()`), never from anything the browser sends.
- cashpresso then calls back asynchronously. The callback handler recomputes a
  **SHA‑512 verification hash** from your secret and the message fields and
  **rejects the request unless the hash matches** — so a forged or tampered
  callback cannot complete an order. On a verified callback, SUCCESS captures the
  payment, CANCELLED voids it, and TIMEOUT expires it.
- Outbound API calls use Guzzle's default **TLS verification (enabled)**.

There is nothing extra you must switch on for this protection — it is how the
gateway works. Your main responsibility is to **keep the shared secret
confidential**, since it is what makes the callback verification trustworthy.

## Optional: product‑page financing and direct checkout

- The module can render a **financing‑cost label** on product pages so shoppers see
  an estimated monthly instalment before buying.
- An optional **direct‑checkout** button ("finance this now") adds an item and
  jumps to checkout. Its route resolves the price **server‑side** and requires the
  **`access checkout`** permission plus the customer's view access to the product,
  so it can't be abused to check out arbitrary or mispriced items.
