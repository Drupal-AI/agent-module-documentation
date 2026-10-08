# Configuration

Commerce BTCPay is configured as a Commerce payment gateway; there is no separate
settings page. Before you start, make sure your BTCPay Server store exists and has
at least a Bitcoin or Lightning wallet configured.

## Add and pair the payment gateway

1. Log in as a user who can administer Commerce.
2. Go to **Administration → Commerce → Configuration → Payment gateways**
   (`/admin/commerce/config/payment-gateways`).
3. Click **Add payment gateway**, give it a **Name** and machine name, and under
   **Plugin** choose **BTCPay Server (Off-site redirect)**.
4. Enter your **BTCPay Server URL** (for example
   `https://btcpay.yourdomain.tld`) — the server where you created your store. It
   **must use HTTPS**.
5. Set the gateway's **Status** to **Disabled** and **Save**. The API key and Store
   ID may be blank for this first save — the **Generate API Key** button only works
   after the gateway has been saved once.
6. Edit the saved gateway and click **Generate API Key**. You'll be redirected to
   your BTCPay Server's authorization page.
7. On BTCPay, select the **store** you want to connect and click **Continue**.
8. Give the app a **label** (for example "Drupal 11 store") and click **Authorize
   app**. BTCPay requests only the least-privilege permissions the module needs.
9. You'll be redirected back to Drupal and asked to **confirm** the authorization.
   The module then verifies the key against BTCPay and stores the **store id**,
   the encrypted **API key**, and a signed **webhook**.
10. Finally, **edit the verified gateway, set its Status to Enabled, and Save.** An
    enabled gateway will not save without a verified API key.

## Other fields

- The gateway is **live-only** — there is no Test/Live mode selector (it is hidden),
  so test against a BTCPay test server or a small real invoice.
- **Send the customer email address to BTCPay Server** — off by default, to
  minimise customer data shared with the payment server. Leave it off unless you
  need BTCPay to email the buyer.
- **New webhook secret** — leave blank to let the module generate a strong secret
  automatically (recommended); a value you enter must be at least 32 characters.
- **Debug mode** — logs extra non-sensitive payment-state details for
  troubleshooting.
- Any wallet/currency options depend on what your BTCPay Server store supports.

Once enabled, place a test order to confirm the invoice is created and the order is
marked paid once BTCPay reports the invoice settled.

## How the API key is stored

You do not need to configure secret storage yourself. The API key and webhook
secret are **encrypted** (AES-256-GCM) and kept in Drupal's **non-exportable**
key/value storage — they are deliberately **absent from configuration exports** and
never written to `settings.php` or config YAML. Because the encryption key is
derived from site-specific secrets, credentials **do not transfer between
environments**: authorize the gateway separately on each site (dev, staging,
production). Always run both your Drupal site and BTCPay Server over **HTTPS**.

## Security notes

- Payment status is **verified server-side**. The webhook (IPN) handler first
  validates the `BTCPay-Sig` **HMAC signature** over the raw request body, then
  **re-fetches the authoritative invoice** directly from your BTCPay Server
  (`getInvoice()`) and records the payment from that verified status — the posted
  event type is never trusted to decide the outcome. The same re-fetch runs when
  the customer returns from BTCPay.
- Each update cross-checks that the invoice matches the right payment, order, store,
  and **amount + currency**, and duplicate/replayed webhook deliveries are ignored.
- The **notification route is public** (`_access: TRUE`), which is standard for a
  Commerce IPN endpoint; it is safe here because it is gated by the signature check
  and the authoritative re-fetch, so a forged notification cannot mark an order
  paid.
- This is an **alpha** release (reported stable by the maintainers) — validate the
  behaviour for your version before going live.
