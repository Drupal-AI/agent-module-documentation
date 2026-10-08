<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Viva Wallet (commerce_vivawallet) — agent index

A **Drupal Commerce off-site payment gateway for Viva Wallet / Viva.com** (Greek/EU PSP). At
checkout the shopper is redirected to Viva's **Smart Checkout** to pay; Viva returns the
customer to a success/cancel URL and also POSTs a **Transaction Payment Created** webhook. On
every path the module **re-fetches the transaction from Viva's authenticated OAuth2 API** and
sets the Commerce payment state from that server-side transaction — the request/webhook status
fields are never trusted. Package `Commerce (contrib)`. Core `^9 || ^10 || ^11 || ^12`. License
GPL-2.0-or-later. Installed as **1.1.1** (version dir `1.1.x`). `security_advisory_coverage:
covered`.

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce`**, **`commerce:commerce_payment`**.
- `composer.json`: **`drupal/commerce` `^2.30 || ^3.0`**. No third-party PHP SDK — Viva's REST
  API is called directly through Drupal's Guzzle client factory with a custom middleware stack.

## What it provides (from source)

- **One payment gateway plugin** `vivawallet` — `Vivawallet`
  (`src/Plugin/Commerce/PaymentGateway/Vivawallet.php`, extends `OffsitePaymentGatewayBase`,
  `requires_billing_information = TRUE`). Its `offsite-payment` form is `VivawalletOffsiteForm`.
- **Payment method type** `vivawallet` — `VivaWallet`
  (`src/Plugin/Commerce/PaymentMethodType/VivaWallet.php`).
- **Off-site redirect form** `VivawalletOffsiteForm`
  (`src/PluginForm/VivawalletOffsiteForm.php`) — creates the remote Viva order and redirects the
  browser to Smart Checkout.
- **Callback controller** `VivawalletController` (`src/Controller/VivawalletController.php`) —
  `success()`, `cancel()`, `hook()` (webhook POST), `verifyHook()` (webhook verification GET).
- **Two access checks**: `VivawalletCallbackAccessCheck` (`_commerce_vivawallet_callback`, for
  success/cancel) and `VivawalletHookAccessCheck` (`_commerce_vivawallet_hook`, for the POST
  webhook) — both in `src/Access/`.
- **`PaymentManager`** (`src/PaymentManager.php`) — loads the local `commerce_payment` entity by
  Viva order code or transaction id (queries `accessCheck(FALSE)`).
- **A layered HTTP/service stack** under `src/Service/` — one `ClientFactory` per Viva host
  (`account`, `api_oauth`, `api_basic`) plus Guzzle middleware (auth, logging, JSON decode,
  header/status validation) and typed services: `AccountService` (OAuth2 token),
  `OrderService` (create order), `TransactionService` (fetch transaction), `ConfigService`
  (fetch webhook verification key). See [payment-flow.md](payment-flow.md).
- **Config schema** (`config/schema/commerce_vivawallet.schema.yml`) for the gateway plugin.

No `.install`, no `.module`, no `.permissions.yml` (routes use custom access checks / anonymous),
no templates, no JS, no `.api.php`, no tests.

## Routes & access

All four routes live at `/commerce-vivawallet/{payment_gateway}/…` and carry `no_cache: TRUE`;
`{payment_gateway}` is upcast to a `commerce_payment_gateway` entity.

| Route | Path suffix | Method | Access | Purpose |
|-------|-------------|--------|--------|---------|
| `commerce_vivawallet.success` | `/success` | GET | `_commerce_vivawallet_callback: TRUE` | Customer return after paying. |
| `commerce_vivawallet.cancel` | `/cancel` | GET | `_commerce_vivawallet_callback: TRUE` | Customer return after cancel/failure. |
| `commerce_vivawallet.hook` | `/hook` | POST | `_commerce_vivawallet_hook: TRUE` | Viva "Transaction Payment Created" webhook. |
| `commerce_vivawallet.verify_hook` | `/hook` | GET | `_user_is_logged_in: FALSE` | Viva webhook URL-ownership verification (echoes the merchant Key). |

`_commerce_vivawallet_callback` requires: the gateway plugin is a Vivawallet gateway; query
params `t` (a valid UUID = Viva transactionId) and `s` (digits = Viva orderCode) present; and a
matching local payment exists. `_commerce_vivawallet_hook` requires: valid gateway; well-formed
JSON body; `EventTypeId === 1796`; integer `OrderCode` + UUID `TransactionId`; and a matching
local payment exists. See [payment-flow.md](payment-flow.md) for how status is then established.

## Configuration (gateway plugin config)

Set at **Commerce → Configuration → Payment gateways** (add the "Viva Wallet" plugin). Stored
per mode (`test` and `live`), from `defaultConfiguration()` / schema:

- `merchant_id`, `api_key` — Basic-auth credentials for Viva's classic `api_basic` host.
- `client_id`, `client_secret` — OAuth2 client-credentials for the `account`/`api_oauth` hosts.
- `source_code` — the Viva payment source code (default `Default`).
- `log_all_requests` — when TRUE, logs every API request/response to the `commerce_vivawallet`
  channel; when FALSE only failures are logged. Default TRUE in `test`, FALSE in `live`.
- `color` (top-level, not per-mode) — hex color for Smart Checkout (default `047f8f`).

**Gateway id matters:** the success/cancel/webhook URLs embed the gateway machine id, so the
Viva payment source and webhook must be configured against the same id (see the README).

## Viva hosts & endpoints (from `ClientFactory`)

Each host has a live and a `test`/demo base URL, each overridable via `Settings::get()`
(`commerce_vivawallet_<service>_url_<mode>`):

- **`account`** — `accounts.vivapayments.com` (demo `demo-accounts…`): `POST connect/token`
  (OAuth2 `client_credentials`, Basic client_id:client_secret).
- **`api_oauth`** — `api.vivapayments.com` (demo `demo-api…`), Bearer token: `POST
  checkout/v2/orders` (create order), `GET checkout/v2/transactions/{id}` (fetch transaction).
- **`api_basic`** — `www.vivapayments.com/api` (demo `demo…`), Basic merchant_id:api_key: `GET
  messages/config/token` (fetch the webhook verification Key).
- **Smart Checkout redirect** — `www.vivapayments.com/web/checkout` (demo `demo.vivapayments…`),
  overridable via `commerce_vivawallet_redirect_url_<mode>`; browser is sent with `?ref=<order
  code>&color=<hex>`.

## Payment flow & verification posture

Off-site redirect → Viva Smart Checkout → customer return (`success`/`cancel`) and/or webhook
(`hook`). On **all** completion paths the controller calls `TransactionService::get()` — a
**server-side, Bearer-authenticated `GET checkout/v2/transactions/{id}`** — and derives the
payment state from the returned `statusId` (only `C`/`F` → `completed`; `A`/`M*` →
`authorization`; `X`/`ML`/`E` → `authorization_voided`; `R` → `refunded`). Before applying it,
`processTransaction()` asserts the local payment's stored `remote_id` equals the fetched
transaction's `transactionId` or `orderCode`, binding the Viva transaction to this payment.
Request/webhook `status` fields are never trusted. HTTP uses Drupal's Guzzle client factory with
default TLS verification (no `verify => false`). Full walkthrough:
[payment-flow.md](payment-flow.md).

## Gotchas

- **Four credentials, two auth schemes.** `merchant_id`+`api_key` (Basic) drive the classic
  `api_basic` host; `client_id`+`client_secret` (OAuth2) drive the modern `account`/`api_oauth`
  hosts. All four are required on the gateway form.
- Credentials are stored in gateway **configuration** (plain `string` schema, not a Key entity)
  and rendered as plain text fields. Exported config carries them — the README recommends
  excluding them via `config_ignore` or similar. See
  [human-docs/configuration](../human-docs/configuration/index.md).
- **`log_all_requests` defaults to TRUE in test mode** and logs full API request options and
  response bodies to the `commerce_vivawallet` logger channel. Turn it off outside debugging.
- The offsite form creates the remote Viva order **once** (guarded by `!$payment->getRemoteId()`)
  and stores the returned `orderCode` as the payment `remote_id`; it also sets a 1-hour default
  expiry that becomes Viva's `paymentTimeOut`.
- `success()` calls `PaymentOrderUpdater::updateOrders()` immediately after processing — a
  deliberate workaround for a "headers already sent" error when the cart session is torn down
  (see CHANGELOG 1.1.1).
- The webhook `hook` route filters on `EventTypeId === 1796` (Transaction Payment Created); other
  Viva event types are rejected by the access check.
- No `.install` / update hooks; enabling only registers the plugin, routes, and services.

## Related docs

- [payment-flow.md](payment-flow.md) — redirect payload, callback/webhook handling, transaction
  re-fetch, order-binding, status mapping.
- [usage.md](../usage.md) — one-line capability summary.
- [human-docs/](../human-docs/index.md) — human setup/config guide.
