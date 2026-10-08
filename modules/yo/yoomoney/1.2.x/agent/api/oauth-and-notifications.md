<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OAuth connection, routes, webhooks, SDK client

The store is linked to a YooMoney merchant profile through a browser-driven OAuth flow rather than
by pasting a shop id + secret key. All of it hangs off the payment-gateway settings form and four
AJAX routes.

## Routes (`yookassa.routing.yml`, `YooKassaOauthController`)

All four require `_permission: 'administer commerce_payment_gateway'` and expect an XHR
(`$request->isXmlHttpRequest()`):

- `/get_oauth_url` → `getOauthUrl()` — ensures the gateway config exists (creating it from the
  posted form via `YooKassaPaymentMethodHelper::savePaymentMethod()` if new), then asks the
  YooMoney OAuth CMS app for an authorization URL and returns `{oauth_url}`.
- `/get_oauth_token` → `getOauthToken()` — after the merchant authorizes, exchanges for an access
  token; stores `access_token`, `token_expires_in`, `notification_url`, `status=1`; revokes any
  previous token; fetches shop info; registers webhooks; returns the gateway edit-form URL.
- `/check_payment_method` → `checkPaymentMethod()` — validates the machine name is present and not
  already taken.
- `/generate_notification_url` → `generateNotificationUrl()` — returns
  `YooKassa::generateNotificationUrl($name)`, i.e. the Commerce `commerce_payment.notify` URL for
  the gateway.

The client side is `js/yookassa_oauth.js` (library `yookassa/oauth`), attached on gateway
add/edit by `yookassa_preprocess_page()`.

## OAuth client (`src/Oauth/YooKassaOauth.php`)

Talks to the YooMoney OAuth CMS app at `https://yookassa.ru/integration/oauth-cms` with three
sub-routes: `authorization`, `get-token`, `revoke-token`.

- `state` — a per-gateway id stored in config (`oauth_state`); generated as
  `substr(md5(time()), 0, 12)` on first use (`getOauthState()`).
- `generateOauthUrl()` POSTs `{state, cms:'drupal', host}`; `generateOauthToken()` POSTs
  `{state}`; `revokeOldToken($token)` POSTs `{state, token, cms}`.
- `saveConfigurationPayment()` writes keys onto the editable
  `commerce_payment.commerce_payment_gateway.<id>` config and saves.
- `saveShopInfoByOauth()` calls the SDK `$client->me()` and stores `shop_id = account_id`.
- Requests go through `sendRequest()` using `\Drupal::httpClient()->post()`.

## SDK client factory (`src/Oauth/YooKassaClientFactory.php`)

`getYooKassaClient(array $config)` returns a **process-static singleton** `YooKassa\Client`.
`createClient()` sets the auth token from `$config['access_token']` (`setAuthToken`), attaches the
`yookassa` logger, and sets the user-agent CMS = `drupal`/`Drupal::VERSION`, module =
`yoo_api_drupal10`/module version. Note the singleton: the first `$config` seen in a request wins;
subsequent calls reuse that client.

## Webhook registration (`src/Oauth/YooKassaWebhookSubscriber.php`)

`subscribe(Client $client, array $config)` runs during `getOauthToken()`. It reconciles the
merchant's webhook list against the required set — `payment.succeeded`, `payment.canceled`,
`payment.waiting_for_capture`, `refund.succeeded` — pointing each at
`$config['notification_url']`, removing mismatched-URL hooks and adding any missing ones. That URL
is the Commerce `commerce_payment.notify` endpoint handled by `YooKassa::onNotify()` (see
plugins/payment-gateway.md).

## Telemetry (`src/Helpers/YooKassaLoggerHelper.php`)

Fire-and-forget metrics to `https://yookassa.ru/integration/oauth-cms/metric/drupal`
(`sendHeka`/`sendBI`/`sendAlertLog` → `sendMetric` → `makeRequest`), tagged with cms/host/shop_id.
Failures are swallowed and logged to the `yookassa` channel; they never block payment flow.

## Statistics helper (`src/Helpers/YooKassaDatabaseHelper.php`)

`getSuccessPaymentStat()` aggregates `COUNT`/`SUM(amount__number)` from `commerce_payment` for
`remote_state='succeeded'`, `RUB`, across all `yookassa` gateways — used only to enrich success
telemetry. Uses the Drupal DB API query builder with bound conditions.
