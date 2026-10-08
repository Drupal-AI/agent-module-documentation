<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Commerce Pesapal Payments (commerce_pesapal) — agent index

A **Drupal Commerce off-site payment gateway for Pesapal**, the payment platform popular
across East Africa (Kenya, Uganda, Tanzania, etc.). At checkout the shopper is redirected to
Pesapal to pay; Pesapal then calls an IPN endpoint on the site and returns the customer to the
order. The module talks to **Pesapal's OAuth 1.0 (HMAC-SHA1) "API v2"** — endpoints
`PostPesapalDirectOrderV4` (create order) and `QueryPaymentStatus` (status) — using a bundled
OAuth PHP library. Package `Commerce (custom)`. Core `^10 || ^11`. License GPL-2.0-or-later.
Installed as **1.0.0-beta1** (version dir `1.0.x`). `security_advisory_coverage: not-covered`
(beta).

## Dependencies

- Drupal modules (`.info.yml`): **`commerce:commerce_payment`**, **`commerce:commerce_order`**,
  **`commerce:commerce_price`**.
- `composer.json`: **`drupal/commerce` `^2.36 || ^3`** and **`php` `>=8.3`**. No third-party
  PHP SDK — the OAuth 1.0 client is vendored at **`includes/OAuth.php`** (global
  `\OAuthConsumer`, `\OAuthRequest`, `\OAuthSignatureMethod_HMAC_SHA1`), loaded via
  `require_once` where needed.

## What it provides (from source)

- **One payment gateway plugin** `pesapal_redirect` — `PesapalRedirect`
  (`src/Plugin/Commerce/PaymentGateway/PesapalRedirect.php`, extends
  `OffsitePaymentGatewayBase`, implements `SupportsNotificationsInterface`). Modes:
  `test` = **Sandbox** (`https://demo.pesapal.com`), `live` = **Live**
  (`https://www.pesapal.com`).
- **Off-site redirect form** `PesapalRedirectForm`
  (`src/PluginForm/OffsiteRedirect/PesapalRedirectForm.php`, `offsite-payment` form, extends
  `PaymentOffsiteForm`). Builds the OAuth-signed redirect URL and submits via `REDIRECT_GET`.
- **IPN controller** `PesapalIpnController::notify`
  (`src/Controller/PesapalIpnController.php`) at route **`/payment/pesapal/ipn`** — finds the
  configured Pesapal gateway and delegates to the plugin's `onNotify()`.
- **Admin status tester** `PesapalStatusTestForm` (`src/Form/PesapalStatusTestForm.php`) at
  **`/admin/commerce/pesapal/status`** — calls `QueryPaymentStatus` for a given
  merchant-reference + tracking-id so an admin can verify credentials before going live. Menu
  link + local task (`*.links.menu.yml`, `*.links.task.yml`).
- **Config schema** (`config/schema/commerce_pesapal.schema.yml`) for the gateway plugin.

No `.install`, no `.module`, no `.permissions.yml` of its own (routes reuse core permissions),
no templates, no JS. One stale unit test (see below).

## Routes & access

| Route | Path | Access | Purpose |
|-------|------|--------|---------|
| `commerce_pesapal.ipn` | `/payment/pesapal/ipn` | `_permission: 'access content'` | Pesapal IPN callback (must be reachable by Pesapal's servers). |
| `commerce_pesapal.status_test` | `/admin/commerce/pesapal/status` | `_permission: 'administer commerce_payment'` | Admin QueryPaymentStatus tester. |

The Commerce `return`/`cancel`/`notify` off-site routes for the gateway are also provided by
`commerce_payment` itself; the `oauth_callback` sent to Pesapal is Commerce's own return URL.

## Configuration (gateway plugin config)

Set at **Commerce → Configuration → Payment gateways** (add the "Pesapal (Redirect)" plugin).
Stored keys (`defaultConfiguration()` / schema):

- `consumer_key_test`, `consumer_secret_test` — Sandbox credentials.
- `consumer_key_live`, `consumer_secret_live` — Live credentials.
- `ipn_url` — optional override for the IPN URL advertised to Pesapal (default route is
  `/payment/pesapal/ipn`).
- `logging_verbosity` — `all` (default) / `errors` / `none`, honored by the plugin's `log()`
  helper writing to the **`commerce_pesapal`** logger channel.
- `mode` — inherited from the base gateway (test/live); `getBaseUrl()` and
  `getCredentialsForMode()` pick the endpoint + credential pair from it.

## Payment flow & verification posture

Off-site redirect → Pesapal → IPN + browser return. On both the IPN (`onNotify()`) and the
browser return (`onReturn()`), the module **re-fetches the transaction status server-side from
Pesapal via an OAuth-signed `QueryPaymentStatus` call** (`queryPaymentStatus()`) and only acts
on a re-fetched **`COMPLETED`** — the status in the request is never trusted as authoritative.
The recorded payment **amount is the server-side order total** (`$order->getTotalPrice()`), and
payments are **de-duplicated by remote transaction id** (`order_id` + `remote_id`). HTTP calls
use Drupal's Guzzle client with default TLS verification. Full walkthrough:
[payment-flow.md](payment-flow.md).

## Gotchas

- Uses Pesapal's **legacy OAuth 1.0 API v2** (`PostPesapalDirectOrderV4`, `QueryPaymentStatus`),
  not the newer 3.0 bearer-token/IPN JSON API. The consumer key/secret are the API v2
  credentials.
- Credentials are stored in gateway **configuration** (plain `string` schema, not a Key entity)
  and rendered in the admin form as plain text fields. Treat exported config as
  secret-bearing; keep it out of version control. See
  [human-docs/configuration](../human-docs/configuration/index.md) for the recommended
  env-var/Key pattern on this project.
- `logging_verbosity: all` (the default) is verbose — it logs the outbound signed redirect URL,
  IPN parameters, and raw status-query responses to the `commerce_pesapal` channel. Set it to
  `errors` or `none` in production.
- `onNotify()` acts only when `pesapal_notification_type == 'CHANGE'`; it always returns an ack
  body echoing the three `pesapal_*` params (Pesapal's expected acknowledgement format).
- Order completion sets `state = 'completed'` directly on the order entity (not via a workflow
  transition) after creating the completed payment.
- `tests/src/Unit/PesapalRedirectTest.php` is **stale** — it asserts config keys
  (`consumer_key`, `consumer_secret`, `base_url`) that the current `defaultConfiguration()` no
  longer provides, so it does not reflect the shipped config and would fail as written. Not a
  runtime concern.

## Related docs

- [payment-flow.md](payment-flow.md) — redirect payload, IPN/return handling, status query,
  order completion.
- [usage.md](../usage.md) — one-line capability summary.
- [human-docs/](../human-docs/index.md) — human setup/config guide.
