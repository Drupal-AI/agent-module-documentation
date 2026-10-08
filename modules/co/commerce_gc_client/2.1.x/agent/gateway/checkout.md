<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Payment gateway & checkout

`Plugin/Commerce/PaymentGateway/GoCardlessClient` — a `CommercePaymentGateway`
(`OffsitePaymentGatewayBase`), id `gocardless_client`, display label "Pay with GoCardless",
modes `sandbox`/`live`, offsite form `PluginForm\PaymentOffsiteForm`.

## Gateway configuration form (`buildConfigurationForm`)

- **Connect / Disconnect** (`submit` `#value` Connect/Disconnect, submit handlers
  `submitConnect` / `submitDisconnect`) — connect is disabled until the payment gateway is
  saved, the private files dir is `configured`, and an adequate SSL cert exists
  (`commerce_gc_client_check_private_directory()`, `commerce_gc_client_get_ssl_status()`).
- **Webhook secret** — once connected, fetched from the partner (`endpoint: webhook_secret`)
  and stored in private files; displayed (HTML-escaped, click-to-copy) plus the webhook URL
  `<base>/gc_client/webhook`. "Change secret" AJAX button regenerates it.
- **General settings**: `currencies` (customer chooses currency at GC), `instant_payments`,
  `countries` (auto-select country for instant payments), `payment_limit` (max auto payments
  per order per day), `email_warnings`. FX options are disabled unless the creditor has
  `fx_payout_currency` (FX Payments enabled at GoCardless).
- **Logging**: `log_webhook`, `log_api` (write webhook/API payloads to the Drupal log).

`defaultConfiguration()`: `currencies`, `instant_payments`, `countries` = FALSE,
`payment_limit` = 3, `email_warnings` = site mail, `log_webhook`/`log_api` = FALSE.

## Connect flow (`submitConnect`)

1. POSTs to `partner_url . '/user/register?_format=json'` to create a partner account with a
   random 24-char username/password.
2. On success, credentials are written to `private://commerce_gc_client/partner_user_<env>`
   and `partner_pass_<env>` (chmod 0600); username also kept in config for compatibility,
   password never stored in config.
3. Redirects (via `TrustedRedirectResponse`) to `partner_url . '/gc_client/connect'` with
   `env`, `name`, `mail`, `client_url` (`<base>/gc_client/connect_complete`), `gateway_id`,
   `module`. Return lands on `Controller/GoCardlessPartnerConnect::complete` (route
   `commerce_gc_client.connect_complete`, `_permission: configure store`), which reports
   status and redirects back to the gateway edit form.

`submitDisconnect` calls partner `oauth/revoke`, clears session + config + private-file
credentials.

## Checkout (offsite redirect) — `PaymentOffsiteForm::buildConfigurationForm`

Builds a GoCardless **Billing Request Flow** and redirects the customer to GoCardless:

- Computes per-item amounts with `commerce_gc_client_price_calculate($order, $item)` (server
  side; FX-adjusted via GC rates; shipping proportion added via the `SHIPMENT` event for
  `flat_rate`/`flat_rate_per_item`).
- Decides `payment_request` (instant payment) vs `mandate_request` (Direct Debit) per item:
  any item with GoCardless recurrence data forces a mandate; instant payment only when
  `instant_payments` is on and a one-off item is set to create a payment immediately.
- Dispatches `BILLING_REQUEST_FLOWS` (alter the flow data), calls partner
  `billing_request_flows/create`, and redirects to the returned URL (validated with
  `UrlHelper::isValid`); on error redirects back to the checkout order-information step.

## Return — `GoCardlessClient::onReturn(OrderInterface $order, Request $request)`

- Reads `billing_request_id` from the query and re-fetches the billing request from the GC
  API (throws `PaymentGatewayException` on failure).
- Shows messages for the instant payment and/or the created/pending mandate, and any FX
  conversion.
- If the mandate already exists, calls `processMandate()` (writes the `commerce_gc_client`
  row binding mandate → order, scheme, customer id). Otherwise mandate creation is finished
  later by the webhook (`billing_requests.fulfilled`).
- For each order item with `gc` data: one-off (`gc_type == 'P'`) → `processPayment()`;
  subscription (`gc_type == 'S'`) → `processSubscription()`. Both are static and reused by
  the webhook and cron paths. See [../recurring/recurring-payments.md](../recurring/recurring-payments.md).

## Gateway filtering

`EventSubscriber/PaymentEventSubscriber` (Commerce `FILTER_PAYMENT_GATEWAYS`) removes the
GoCardless gateway at checkout when the order currency is not in the client's enabled
GoCardless `currency_schemes`.
