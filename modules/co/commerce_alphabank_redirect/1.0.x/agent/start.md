<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Alphabank (commerce_alphabank_redirect) — agent index

**Off-site *redirect* payment gateway for Alpha Bank (Greece) / Cardlink** for Drupal Commerce.
The customer is redirected to the bank's hosted card page (`postUrl`, default the Cardlink
test VPOS), pays there, and the bank returns/POSTs the result to a module callback that records
a Commerce payment. No card data is stored on the Drupal side.

Package `Commerce`. `type: module`. Core `^8.9 || ^9 || ^10 || ^11`. License GPL-2.0-or-later.
Installed version **1.0.3** (version dir `1.0.x`). Composer `drupal/commerce_alphabank_redirect`.

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`**, **`commerce:commerce_payment`**.
- No PHP-library or extra Composer requirements. (Only the old Drupal 7 branch needed
  `commerce_static_checkout_url`; not used here.)

## What it provides (from source)

- **Payment gateway plugin** `alphabank_redirect`
  (`src/Plugin/Commerce/PaymentGateway/AlphabankPaymentRedirect.php`), extends
  `OffsitePaymentGatewayBase`. `payment_method_types = {credit_card}`;
  `credit_card_types = amex, dinersclub, discover, maestro, mastercard, visa`;
  `requires_billing_information = FALSE`. Declares one form:
  `offsite-payment` → `AlphabankPaymentRedirectForm`.
  - **Config fields** (with schema in `config/schema/…schema.yml`): `pay_method`
    (`default` | `iris`), `version` (spec version, "2"), `mid` (merchant id),
    `beneficiary_code` (IRIS only), `currency` (ISO-4217, EUR), `confirmUrl`, `cancelUrl`,
    `shared_secret`, `postUrl`. Plus the base `mode` (test/live) and display fields.
- **Offsite redirect form** `PluginForm/OffsiteRedirect/AlphabankPaymentRedirectForm` — builds
  the auto-POST redirect to `postUrl`. Computes the outbound request **digest**
  (`base64(sha256(<45 positional fields incl. shared_secret>))`), stores
  `{shared_secret, payment_gateway}` in the order's `AlphabankGatewayData` for later
  verification, and POSTs `version, mid, orderid (=<orderId>at<time()>), orderAmount, currency,
  billing fields, confirmUrl, cancelUrl, digest, …`. The `shared_secret` is **not** sent to the
  browser — only the computed `digest` is. Supports an **IRIS** payment method that additionally
  builds a **DIAS RF payment code** (`calculateDiasRFCode` / `calculateAmountCheckDigit` /
  `calculateCheckDigits`, Mod97 + Mod8) and adds payer email/phone.
- **Callback controller** `Controller/CallbackController::callback`
  (route `commerce_alphabank_redirect.payment_callback`, path
  `/commerce_alphabank_redirect/callback`, `_access: 'TRUE'`, `no_cache: TRUE`). On the bank's
  return it **recomputes the digest keyed with the merchant `shared_secret`** and only records a
  `completed` payment when it matches (see the flow doc). It also logs the outcome to dblog and
  to the order's `AlphabankGatewayData`.
- **Alter hook** `hook_commerce_alphabank_redirect_billing_phone_field_alter(&$field_name)`
  (`.api.php`) — change the billing-profile phone field used for IRIS (default `field_phone`).
- **CSS** `css/commerce_alphabank_redirect.css` (checkout receipt / bank-icon styling).
- **Legacy** `commerce_alphabank_redirect.pages.inc` is old Drupal-7 code and is **not wired to
  any route** in this branch (no routing/hook_menu references it); it is inert on D8+.

## Security posture (payment gateway)

Sound. The return handler recomputes a **sha256 digest over the response fields concatenated
with the merchant `shared_secret`** and creates a **`completed`** payment only when the received
`digest` matches — an attacker who doesn't know the secret cannot forge a paid callback. On a
mismatch it records a **non-fulfilling `"Unvalidated"`** payment and logs a failure; Commerce
counts only `completed` payments toward the order total, so a forged/tampered callback cannot
fulfil an order. The recorded amount is the **server-side order balance** (`$order->getBalance()`),
never the callback-supplied amount. The `shared_secret` is never exposed to the browser.
Operational rules: keep the **`shared_secret` genuinely secret** and serve the callback over
HTTPS. See [agent/payment-flow.md](payment-flow.md).

## Solution docs

- **Redirect digest build, callback verification, IRIS/DIAS RF code, config fields** →
  [payment-flow.md](payment-flow.md)
