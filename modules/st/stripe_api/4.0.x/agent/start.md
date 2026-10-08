<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stripe API (stripe_api) — agent index

Wires the **Stripe PHP SDK** (`stripe/stripe-php`) into Drupal as reusable infrastructure — **not a
payment feature**. It gives other modules three things: credential storage through the **Key** module,
a pre-configured `\Stripe\StripeClient` via the `stripe_api.stripe_api` service, and a webhook endpoint
at `/stripe/webhook` that turns Stripe's callbacks into a dispatched Drupal event (`stripe_api.webhook`)
that any module can subscribe to. It ships no checkout, no order handling and no products — a
subscription, donation or commerce module is expected to build those on top of this one client + one
event. Version **4.0.2**, core `^8 || ^9 || ^10 || ^11`, package `Stripe`.

Configuration lives at `/admin/config/services/stripe_api` (route `stripe_api.admin`, form
`StripeApiAdminForm`), gated by the `administer stripe api` permission. Keys are chosen with the Key
module's `key_select` element, so only the Key entity **id** is stored in `stripe_api.settings` — never
the raw secret. Two modes (`test`/`live`) each have their own secret key, publishable key and webhook
signing secret; a page-level warning message is shown site-wide while `mode` is `test`
(`hook_preprocess_page` in `stripe_api.module`).

- Depends on: `key:key` (hard). Pulls in `stripe/stripe-php` via Composer.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Stripe`.
- Settings page: **yes** — `configure: stripe_api.admin`. Permission: `administer stripe api`.
- No drush commands. No plugin types. Provides config schema. One event: `stripe_api.webhook`.

## What you'd do → where

- **Inject the Stripe client / call the Stripe API from your module; read keys, mode, API version** →
  [api/service.md](api/service.md)
- **Subscribe to incoming Stripe webhook events (`stripe_api.webhook`)** → [api/service.md](api/service.md)
- **Set API keys, choose test/live mode, set the API version, enable/log webhooks, find the webhook URL
  + signing secret** → [configure/settings.md](configure/settings.md)

## Key facts (real machine names)

- Routes: `stripe_api.admin` (`/admin/config/services/stripe_api`, `_permission: administer stripe api`),
  `stripe_api.webhook` (`/stripe/webhook`, **POST**, `_content_type_format: json`,
  `_permission: access content`), `stripe_api.webhook_redirect` (`/stripe/webhook`, GET/HEAD/PUT/DELETE).
- Controllers: `Drupal\stripe_api\Controller\StripeApiWebhook::handleIncomingWebhook`,
  `StripeApiWebhookRedirect::webhookRedirect`.
- Service: `stripe_api.stripe_api` → `Drupal\stripe_api\StripeApiService`
  (args `@config.factory`, `@entity_type.manager`, `@logger.channel.stripe_api`, `@key.repository`).
  Logger channel: `logger.channel.stripe_api`.
- Service methods: `getStripeClient(array $config = [])`, `getApiKey()`, `getPubKey()`,
  `getWebhookSigningSecret()`, `getMode()`, `getApiVersion()`.
- Event: dispatched as `'stripe_api.webhook'` with `Drupal\stripe_api\Event\StripeApiWebhookEvent`
  (public props `->type`, `->event` = `\Stripe\Event`). Bundled subscriber:
  `stripe_api.webhook_subscriber` (`Event\StripeApiWebhookSubscriber::onIncomingWebhook`, log-only).
- Form: `Drupal\stripe_api\Form\StripeApiAdminForm` (id `stripe_api_admin_form`).
- Permission: `administer stripe api`. Config object: `stripe_api.settings`.
- Config keys: `mode`, `test_secret_key`, `test_public_key`, `live_secret_key`, `live_public_key`,
  `test_webhook_signing_secret`, `live_webhook_signing_secret`, `api_version`, `api_version_custom`,
  `enable_webhooks`, `log_webhooks`. Env override: `STRIPE_WEBHOOK_SIGNING_SECRET`.
- Composer: `stripe/stripe-php:^7.36`, `drupal/key:^1.13`.
