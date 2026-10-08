# Configuration

Setting up Cybersource SOP has three parts: the **credentials file**, the
**Commerce gateway**, and the matching **Secure Acceptance profile** in the
Cybersource Business Center.

## Step 1 — Place the credentials file

Credentials are deliberately kept out of Drupal configuration (never written to
the database or exported to config):

1. Copy the shipped example `cybersource.credentials.example.yml` into your
   private files directory (for example `private://keys/cybersource.yml`).
2. Fill in your Secure Acceptance profile values — `profile_id`, `access_key`,
   and `secret_key`. The file supports **one test profile for all currencies** and
   **one live profile per currency**.
3. Make it **readable by the web server user only**.

Never commit the filled‑in credentials file. If you manage secrets as environment
variables (for example with DDEV's `ddev dotenv set .ddev/.env …`), inject them
into the `.yml` at deploy time rather than storing the real values in the
repository. The gateway panel and the site status report warn when the file is
missing and before a security key expires.

## Step 2 — Add the payment gateway

1. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`) and click **Add payment gateway**.
2. Choose the **Cybersource (Secure Acceptance SOP)** plugin.
3. Set the fields:
   - **Mode** — **Test** or **Live**. This chooses the test or live credential
     profile (and, for live, resolves the per‑currency profile).
   - **Transaction type** — **Authorization** (place a hold) or **Sale**
     (authorize and capture in one step).
   - **Locale** — the language/locale for the Secure Acceptance experience.
4. Save the gateway. The panel reports whether the credentials file was found.

## Step 3 — Configure the Secure Acceptance profile at Cybersource

In the **Cybersource Business Center**, on the Secure Acceptance profile that
matches the `profile_id` in your `.yml`:

1. Choose the **Silent Order POST** integration method.
2. Enable **card payments** and the currencies you take.
3. Allow the merchant to **override the customer response page** (so replies come
   back to your Drupal return route).
4. **Activate** the profile and **generate a security key** — this key is the
   `secret_key` in your credentials file.

## How replies are trusted

You don't configure this, but it's why the gateway is safe to run on your own
checkout page:

- Every Cybersource reply must carry a **valid HMAC‑SHA256 signature**, verified
  with constant‑time comparison.
- The signature must **cover** `decision`, `reason_code`, `req_reference_number`,
  `transaction_id`, `req_amount`, and `req_currency` — a reply that appends an
  unsigned amount or decision is rejected.
- The recorded amount is the **order total**; the signed `req_amount` /
  `req_currency` must match it or the payment is refused.
- The same transaction is **never recorded twice** (replay guard), and Decision
  Manager reviews are held as pending rather than auto‑completed.

## Test before going live

Run checkouts in **Test** mode against the Cybersource sandbox first. When you're
satisfied, switch the gateway **Mode** to **Live** so it uses your live,
per‑currency profiles.
