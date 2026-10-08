<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Unzer — agent index

Adds **Unzer** (formerly **Heidelpay**, a German/EU PSP) payment gateways to
**Drupal Commerce**. Ships **two** `commerce_payment_gateway` plugins — an
**on-site** credit-card gateway and an **off-site** hosted-checkout (Paypage)
gateway — both built on the official **`unzerdev/php-sdk`** SDK. Depends on
`commerce:commerce_payment`.

- **Version** `3.0.0-beta2` (beta; the branch is under active development).
- **Package** `Commerce (contrib)`. **License** GPL-2.0-or-later.
- **Core** `^10 || ^11` (`commerce_unzer.info.yml`). **PHP** `>=8.1`.
- **Composer** requires `drupal/commerce ^3.0` and `unzerdev/php-sdk ^3.3`
  (`composer.json`). The SDK is the only third-party runtime library; all Unzer
  API calls go through it.
- **No** `routing.yml`, `services.yml`, or `permissions.yml` — the gateways use
  Commerce's generic off-site/on-site routes and admin UI; the module defines **no
  routes and no permissions** of its own.
- **PHP config caveat** (README): set `serialize_precision = -1`, otherwise the
  SDK raises rounding-error exceptions for some amounts.

## What ships

- `src/Plugin/Commerce/PaymentGateway/UnzerOffSite.php` — the
  `#[CommercePaymentGateway(id: 'commerce_unzer_offsite')]` plugin, extends
  `OffsitePaymentGatewayBase`, implements `HasPaymentInstructionsInterface`.
  Holds the config form, `onReturn()`/`processNotification()`, `onCancel()`, and
  the static `getUnzerPaymentTypes()` / `getUnzerOptionalPaypageSettings()` maps.
  `onNotify()` is a `@TODO` stub returning `NULL` (no webhook handler; completion
  runs entirely through `onReturn`).
- `src/Plugin/Commerce/PaymentGateway/UnzerOnSite.php` — the
  `#[CommercePaymentGateway(id: 'commerce_unzer_onsite')]` plugin, extends
  `OnsitePaymentGatewayBase`, implements `UnzerOnSiteInterface`. Holds the config
  form, `createPaymentMethod()` (tokenised card), `createPayment()` (server-side
  charge + 3-D Secure redirect), `deletePaymentMethod()`, `getPublicKey()`.
- `src/Plugin/Commerce/PaymentGateway/UnzerOnSiteInterface.php` — marker interface
  extending `OnsitePaymentGatewayInterface`, adds `getPublicKey()`. `@TODO`
  comments note refunds/authorisations are not yet supported.
- `src/PluginForm/OffsiteRedirect/UnzerForm.php` — the `offsite-payment` plugin
  form. Builds the Unzer **Paypage V2** server-side (customer, basket, payment-
  method configs, URLs, style), stores `paypage_id` on the order, and issues a
  `REDIRECT_GET` to the paypage redirect URL. Dispatches two events (below).
- `src/PluginForm/Unzer/PaymentMethodAddForm.php` — the on-site `add-payment-method`
  form. Renders empty `unzerUI` containers for card/expiry/cvc/holder, attaches the
  `commerce_unzer/form` library, and exposes the **public key** via
  `drupalSettings.commerceUnzer.publicKey`. A hidden `unzer_resource_id` field is
  populated by the JS after client-side tokenisation. Server-side validation is a
  no-op (the JS library validates).
- `src/Utility/UnzerAddressConverter.php` — maps a Commerce billing `AddressItem`
  to Unzer customer/address fields, truncating to Unzer's length limits and
  falling back to `Unknown` for missing mandatory first/last names.
- `src/DebugHandler.php` — `UnzerSDK\Interfaces\DebugHandlerInterface`
  implementation that forwards SDK debug output to the `commerce_unzer` logger
  channel at `LogLevel::DEBUG`. Only wired up when the off-site gateway's
  `debug_logging` is enabled.
- `src/Event/PreOffsiteRedirectEvent.php` — dispatched before the off-site
  redirect; lets subscribers rewrite the paypage settings and the excluded-
  payment-types list.
- `src/Event/DetermineUnzerOrderIdEvent.php` — dispatched before the redirect; lets
  subscribers override the order id sent to Unzer (defaults to `$order->id()`).
- `commerce_unzer.libraries.yml` — `unzer` (external `unzer.js` + `unzer.css`
  from `static.unzer.com/v1/`) and `form` (`js/commerce_unzer.form.js`, depends on
  jQuery + `unzer`).
- `js/commerce_unzer.form.js` — instantiates `unzer(publicKey)`, mounts the hosted
  Card fields, and on submit calls `Card.createResource()` to obtain a card token,
  writing its id into `#unzer-resource-id` before re-submitting.
- `commerce_unzer.install` — `commerce_unzer_update_10001()` strips the obsolete
  `tagline` / `shop_description` paypage settings (they called SDK methods that no
  longer exist and caused fatal errors at checkout).
- `config/schema/commerce_unzer.schema.yml` — typed config for both gateway plugins.

## Gateway configuration

Set on the Commerce payment-gateway entity
(`/admin/commerce/config/payment-gateways`). Keys from each plugin's
`defaultConfiguration()` and the schema.

**On-site** (`commerce_unzer_onsite`):

| Key | Type | Notes |
| --- | --- | --- |
| `private_key` | textfield | Unzer private key; used **server-side** for the SDK charge. |
| `public_key` | textfield | Unzer public key; sent to the browser for tokenisation. |
| `3ds` | radios (default TRUE) | Require 3-D Secure; on `true` the flow redirects to Unzer for the challenge. |
| `account_holder` | checkbox (default FALSE) | Show the account-holder card field. |

**Off-site** (`commerce_unzer_offsite`):

| Key | Type | Notes |
| --- | --- | --- |
| `private_key` | textfield | Unzer private key; server-side Paypage create + payment re-fetch. |
| `public_key` | textfield | Unzer public key. |
| `instructions` | text_format | Shown after checkout via `buildPaymentInstructions()`. |
| `debug_logging` | checkbox | Route SDK debug output to the `commerce_unzer` log channel. |
| `excluded_payment_types` | checkboxes | Unzer payment types to hide on the paypage even if enabled in the Unzer account. |
| `paypage_settings` | mapping | Optional paypage branding: `logo_image`, `full_page_image`, `shop_name`, `terms_and_conditions_url`, `privacy_policy_url`, `imprint_url`, `help_url`, `contact_url`. |

Plus the standard Commerce gateway `mode` (test/live) and `display_label`. Note the
form warns that `mode` only labels payments in Drupal — test vs. live is actually
determined by which Unzer key pair you enter.

## Payment flows

**On-site** (`UnzerOnSite`):

1. `PaymentMethodAddForm` renders the hosted Unzer card fields; the JS tokenises
   the card client-side and posts back only a `unzer_resource_id`.
2. `createPaymentMethod()` re-fetches that resource server-side
   (`Unzer::fetchPaymentType()` with the **private key**) to read card brand /
   masked number / expiry and stores a `commerce_payment_method`.
3. `createPayment()` builds an Unzer `Charge` (order total + currency + the
   checkout URL as return), attaches customer + basket, sets `card3ds`, and calls
   `Unzer::performCharge()` server-side. The completed `commerce_payment` is saved
   **only** on `$transaction->isSuccess()`; a pending/error non-3ds result throws
   `PaymentGatewayException`; a pending 3-D-Secure result redirects the browser to
   Unzer's `getRedirectUrl()`. On the 3ds return the charge is re-fetched
   (`fetchPayment()->getCharge()`) using ids stored on the order.

**Off-site** (`UnzerOffSite` + `UnzerForm`):

1. `UnzerForm::buildConfigurationForm()` creates/updates the Unzer customer
   (external id `uid-<uid>` for authenticated users), builds a basket from order
   items + adjustments, constructs a **Paypage V2** (`TransactionTypes::CHARGE`,
   `PAYMENT_ONLY`) with the return/cancel URLs, dispatches
   `PreOffsiteRedirectEvent` and `DetermineUnzerOrderIdEvent`, calls
   `Unzer::createPaypage()`, stores the resulting `paypage_id` in the order's
   `commerce_unzer` data, and redirects (`REDIRECT_GET`) to the paypage.
2. On return, `onReturn()` → `processNotification($order)` reads the server-stored
   `paypage_id`, re-fetches it with the **private key**
   (`Unzer::fetchPaypageV2()`), takes the embedded payment id, re-fetches the full
   payment (`Unzer::fetchPayment()`), and records a `completed` `commerce_payment`
   **only** when the Unzer payment state is `PaymentState::STATE_NAME_COMPLETED`;
   otherwise it throws `InvalidRequestException`. Remote id is the initial
   transaction's short id (falling back to the payment id).
3. `onCancel()` steps the checkout flow back one step (Unzer has no cancel URL).
   `onNotify()` does nothing (stub).

## Events (integration points)

- `PreOffsiteRedirectEvent($order, $paypageSettings, $excludedPaymentTypes)` —
  getters/setters for paypage settings and excluded payment types; dispatched in
  `UnzerForm` before the paypage is built.
- `DetermineUnzerOrderIdEvent($order, $unzerOrderId)` — override the order id sent
  to Unzer (e.g. to add a store prefix for shared key pairs).

## Security posture (positive)

Completion truth is anchored to Unzer's **authenticated** API (private key), not to
returning request parameters:

- **Off-site** `onReturn()` re-fetches the paypage and payment server-side
  (`fetchPaypageV2()` → `fetchPayment()`) and records the payment only when Unzer
  reports the payment state `COMPLETED`. The `paypage_id` it re-fetches is stored
  server-side on the order, not read from the request.
- **On-site** charges run server-side via `performCharge()`; the browser only
  handles a tokenised card resource, and the paid `commerce_payment` is saved only
  on `isSuccess()`.
- The **public** key alone is exposed to the browser; the **private** key stays
  server-side. API calls go through the `unzerdev/php-sdk` default HTTP adapter with
  its standard TLS verification.

Operational note: the private/public keys live in gateway config. Keep the private
key out of committed configuration (env / settings override) and serve the site over
HTTPS.

## See also

- `../usage.md` — task-oriented summary.
- `../human-docs/` — UI setup guide for site builders.
