# Configuration

Configuring Cybersource REST has two distinct parts: placing the **credentials
file** on the server (deliberately kept out of Drupal), and adding the **payment
gateway** in Commerce.

## Step 1 — Place the credentials file

The module never stores API credentials in site configuration, the database, or
git. Instead it reads them from a private `.yml` file:

1. Find the example file shipped with the module,
   `cybersource_rest.credentials.example.yml`, and copy it into your private files
   directory (for example `private://keys/cybersource_rest.yml`).
2. Fill in the two profiles — **`test`** and **`live`** — each with your
   `merchant_id`, `key_id`, and `shared_secret` from the Cybersource account.
3. Make the file **readable by the web server user only**, and confirm it sits
   outside the web root (it should, if it's in the private filesystem).

Keeping the actual secret values out of the repository is the whole point. If you
manage secrets as environment variables (for example with DDEV's
`ddev dotenv set .ddev/.env …` and a restart), inject them into the `.yml` at
deploy time rather than committing the real values — never commit the filled‑in
credentials file. The gateway's admin panel and the site status report will warn
you when the file is missing, in test mode, or when a key is nearing expiry.

## Step 2 — Add the payment gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Cybersource REST** plugin.
3. Set the fields:
   - **Mode** — **Test** or **Live**. This selects which credential profile
     (`test` / `live`) and which fixed Cybersource API host is used.
   - **Transaction type** — **Authorize and capture** (charge immediately at
     checkout) or **Authorize only** (place a hold now and capture later from the
     order screen).
   - **3‑D Secure / Payer Authentication** — enable it to require EMV 3DS 2.x
     authentication for card‑not‑present fraud reduction and SCA. When enabled,
     the payment fails closed if authentication is skipped or tampered with.
   - **Accepted card types** — the card brands shown and enforced on the payment
     form.
4. Save the gateway.

## How money movements are protected

A few behaviors are worth understanding, because they are enforced regardless of
what the browser sends:

- The **charged amount and currency always come from the order**
  (`$order->getTotalPrice()`), never from client input.
- **Capture, void, and refund** each verify the Cybersource status before
  recording the movement, and every movement is written to the order's activity
  log (card data is never logged).
- A payment request that gets **no response** is flagged for manual
  reconciliation rather than assumed failed, and **Decision Manager reviews** are
  held as pending authorizations rather than auto‑completed.

## Test before going live

Add the gateway in **Test** mode first and run checkouts against the Cybersource
sandbox (the module's README documents a 3‑D Secure test‑card matrix). When you're
satisfied, switch the gateway **Mode** to **Live** so it uses the `live`
credential profile and the live Cybersource host.
