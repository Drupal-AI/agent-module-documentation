<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce VictoriaBank Moldova (commerce_vb_md) — agent index

Human-readable name (`commerce_vb_md.info.yml`): **"Commerce VictoriaBank Moldova"** —
_"Provides Commerce integration for VictoriaBank Moldova Payment."_

An **off-site Drupal Commerce payment gateway for VictoriaBank** (a bank in Moldova,
`vb.md`). At checkout the shopper is POST-redirected to VictoriaBank's hosted card
page; the bank then **POSTs a signed callback** to `/commerce-vb-md/callback`, which
the module verifies by **RSA** before creating/advancing the Commerce payment. Card
capture ("complete sales", TRTYPE 21) and refund (TRTYPE 24) are driven as
**referenced transactions** over server-to-server cURL to the bank. All amounts are in
**MDL** (module install requires the MDL currency).

- **Version** `1.0.0` (version dir `1.0.x`). **Package** `Commerce`.
- **Core** `^8 || ^9 || ^10 || ^11` (from `commerce_vb_md.info.yml`).
- **PHP** `^8`; composer requires `drupal/commerce ^3` (`composer.json`).
- **Dependency** (`.info.yml`): `commerce:commerce_payment`. (Also uses
  `commerce_order`, `commerce_price`, `commerce_log`, `profile`, `address` at runtime,
  all pulled in by Commerce.)
- **License** GPL-2.0-or-later. `security_advisory_coverage: not-covered`;
  "Minimally maintained". Project page: https://www.drupal.org/project/commerce_vb_md

## What ships (from source)

Plugins (`src/Plugin/Commerce/`):

- **`PaymentGateway/VictoriaBankPaymentGateway`** — `@CommercePaymentGateway(id =
  "victoria_bank")`, extends `PaymentGatewayBase`, implements
  `VictoriaBankPaymentGatewayInterface` (which extends `OffsitePaymentGatewayInterface`,
  `SupportsVoidsInterface`, `HasPaymentInstructionsInterface`). Holds the config form,
  the state-transition methods (`authorizationPayment`/`completePayment`/`refundPayment`/
  `voidPayment`/`createPayment`), the redirect **form data + signature**
  (`getFormData()`), the referenced-transaction option builder
  (`getTransactionOption()`), and endpoint selection (`getUrl()`).
  `payment_method_types = {"victoria_bank"}`, `payment_type = "victoria_bank"`,
  `offsite-payment` form = `PaymentOffsiteForm`.
- **`PaymentMethodType/VictoriaBankMethodType`** — `id = "victoria_bank"` method type
  (label "Victoria Bank").
- **`PaymentType/VictoriaBankPaymentType`** — `id = "victoria_bank"`, `workflow =
  "victoria_bank"`, no extra fields.

Services (`commerce_vb_md.services.yml`):

- **`commerce_vb_md.manager`** → `VictoriaBankManager` — the core orchestrator: parses
  the inbound callback (`preprocessResponse()`), runs the auth/complete/refund flows,
  creates payments, sends the customer email, writes the commerce_log entry, and runs
  the referenced-transaction cURL client (`referencedTransactionClientExecute()`).
- **`commerce_vb_md.serializer`** → `VictoriaBankSerializer` — RSA sign/verify:
  `pSignEncrypt()` (sign outbound requests with the merchant private key) and
  `pSignDecrypt()` (verify the bank callback with the bank public key).
- **`commerce_vb_md.back_ref`** → `VictoriaBankBackRefHandler` — computes the
  post-payment browser redirect (checks order view access, returns to the checkout
  form or `<front>`).

Routes (`commerce_vb_md.routing.yml`) — both `_permission: 'access content'`,
`no_cache: TRUE`:

- **`commerce_vb_md.callback`** `/commerce-vb-md/callback` →
  `VictoriaBankCallbackController::index` — the bank's server-to-server callback
  (the "Callback URL" you give VictoriaBank).
- **`commerce_vb_md.back_ref`** `/commerce-vb-md/{commerce_order}/back-ref` →
  `VictoriaBankBackRefController::index` — where the bank returns the **browser** after
  payment (advertised to the bank as `BACKREF`).

Plugin forms (`src/PluginForm/`):

- **`PaymentOffsiteForm`** — the `offsite-payment` form; builds the auto-submitting
  `REDIRECT_POST` form to the bank from `getFormData()`, dispatches
  `VbMdEvents::PAYMENT_OFFSITE_FORM` (alter the payload), and strips Drupal form
  tokens/ids so the cross-domain POST works.
- **`PaymentCompleteForm`** / **`PaymentRefundForm`** — admin operation forms that fire
  a referenced complete (TRTYPE 21) / refund (TRTYPE 24) via cURL and show the bank's
  filtered response.
- **`PaymentAuthorizationForm`** — empty form (authorization happens when the shopper
  pays by card; nothing to submit).

Other: `commerce_vb_md.workflows.yml` (payment workflow `victoria_bank`:
new→pending→authorization→completed, plus refunded/voided),
`commerce_vb_md.commerce_log_*.yml` (order-log category + template `vb_md_callback`),
`config/schema/commerce_vb_md.schema.yml` (gateway config), `commerce_vb_md.module`
(help, `commerce_vb_md_mail` theme + preprocess, `hook_mail`),
`commerce_vb_md.install` (`hook_requirements` — needs MDL currency),
`templates/commerce-vb-md-mail.html.twig`, `src/Event/VbMdEvents.php`,
`src/Exception/VictoriaBankException.php`.

No `.permissions.yml` of its own; no JS; no Drush.

## RSA key files (required)

The gateway reads two PEM files from the **private filesystem** — configure
`private://` first, then place:

| Path (constant) | Purpose |
| --- | --- |
| `private://vicb_pem/key.pem` (`VictoriaBankManager::PRIVATE_KEY_PEM`) | Merchant **private** key; signs outbound requests (`pSignEncrypt`). |
| `private://vicb_pem/victoria_pub.pem` (`VictoriaBankManager::PRIVATE_VICTORIA_PUB_PEM`) | Bank **public** key; verifies the inbound callback signature (`pSignDecrypt`). |

`buildConfigurationForm()` / `validateConfigurationForm()` block saving the gateway and
show an error if either file is missing. (The bank also needs your own public key —
`pubkey.pem` in the drupal.org setup notes — but the module code does not read that
file itself.)

## Gateway configuration keys

Set on the payment-gateway entity at
`/admin/commerce/config/payment-gateways` (schema in
`config/schema/commerce_vb_md.schema.yml`, form in `buildConfigurationForm()`), plus
the standard Commerce `mode` (test/live) and `display_label`:

| Key | Type | Meaning |
| --- | --- | --- |
| `merch_name` | textfield (req) | Merchant name shown to the cardholder. |
| `merch_url` | textfield (req) | Merchant primary site URL. |
| `merchant` | number (req) | Merchant ID assigned by the bank. |
| `terminal` | number (req) | Terminal ID assigned by the bank. |
| `merch_address` | textfield (req) | Registered office address. |
| `support_contacts` | textfield (req) | Support phone/contact (shown in email). |
| `return_policy_uri` | textfield (req) | Return/refund policy link (validated via `Url::fromUserInput`; shown in email). |
| `auto_complete_sales` | checkbox | If on, immediately fires a complete-sales (TRTYPE 21) after authorization instead of leaving it for manual capture. |
| `instructions` | text_format | Optional payment instructions. |

`getUrl()` picks the endpoint by `mode`: **live** → `https://vb059.vb.md/cgi-bin/cgi_link`
(`URL_PROD`), otherwise → `https://ecomt.victoriabank.md/cgi-bin/cgi_link` (`URL_TEST`).

## Payment / callback flow

Full walkthrough: **[payment-flow.md](payment-flow.md)**. In brief:

1. **Checkout →** `PaymentOffsiteForm` auto-POSTs the shopper to the bank with
   `getFormData()` (amount `number_format(...,0)` MDL, an order id concatenated with a
   timestamp, merchant fields, `NONCE`, `TIMESTAMP`, RSA `P_SIGN`, and `BACKREF` =
   absolute `commerce_vb_md.back_ref` URL).
2. **Bank → callback** (`/commerce-vb-md/callback`, POST): `preprocessResponse()`
   verifies `P_SIGN` (RSA, bank public key) over `ACTION,RC,RRN,ORDER,AMOUNT`, and
   **only on success** loads the order, takes a lock, logs, and dispatches by TRTYPE →
   authorization (0) / complete-sales (21) / refund (24). Authorization creates a
   `commerce_payment` (state `authorization`), advances the checkout step, and either
   auto-completes or emails the customer.
3. **Bank → browser** (`/commerce-vb-md/{order}/back-ref`): re-redirects once with
   `self_reference=1`, then (after an order view-access check) sends the shopper back to
   the Commerce checkout form.
4. **Admin operations:** Complete / Refund plugin forms call
   `referencedTransactionClientExecute()` (cURL POST to `getUrl()`) with a freshly
   signed option set.

## Security posture (positive, plain mechanism)

The inbound bank callback is **RSA-signature-verified**: `pSignDecrypt()` runs
`openssl_public_decrypt()` with the bank's public key (`victoria_pub.pem`) over the
`ACTION,RC,RRN,ORDER,AMOUNT` MAC and compares the decrypted MD5; the callback loads or
changes an order **only when the signature verifies**, and the signed `ORDER` binds the
message to a specific order. The server-to-server referenced-transaction calls
(`referencedTransactionClientExecute`) target the two **hardcoded HTTPS** bank
endpoints (chosen by `mode`) with default TLS verification. The merchant private key
and bank public key are stored in the **private filesystem** (`private://vicb_pem/`),
never in the web root and never placed in admin-form default values.

## See also

- [payment-flow.md](payment-flow.md) — redirect payload, callback verification, and the
  auth/complete/refund handlers, source-grounded.
- [../usage.md](../usage.md) — one-line capability summary.
- [../human-docs/](../human-docs/index.md) — human setup & configuration guide.
