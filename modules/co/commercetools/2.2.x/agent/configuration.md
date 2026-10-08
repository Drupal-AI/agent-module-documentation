<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commercetools — configuration, routes, permissions

## Config objects (base module)

- **`commercetools.api`** — `client_id`, `client_secret`, `project_key`, `scope`,
  `hosted_region`, `cache_responses_ttl` (default `-1`). Plaintext Drupal config
  (no Key/env integration; use a settings.php config override to externalise the
  secret). Read via `CommercetoolsConfiguration`/`config.factory`.
- **`commercetools.settings`** — storefront/behaviour: `items_per_page` (12),
  `card_image_style`, `price_customer_group`, `unavailable_data_text`,
  `checkout_mode` (`local`|`commercetools`), `checkout_commercetools_app_key`,
  `checkout_commercetools_inline`, `display_connection_errors` (true),
  `log_commercetools_requests` (false), `customize_page_attributes(_enabled)`.
- **`commercetools.subscriptions_settings`** — `destination`, `subscription_key`
  (default `drupal-commercetools-module`), `changes` (`product,category,cart`),
  `webhook_token`, `logging` (false).
- **`commercetools.subscriptions_destination_sqs`** — AWS SQS `queue_url`,
  `access_key`, `access_secret`, `region` (plaintext).
- **`commercetools.locale`** — store/language/country/currency/channel mapping
  (managed by `StoreSettingsForm` / `CommercetoolsLocalization`).
- Block settings schemas: catalog / catalog-filters / categories-list /
  product-list blocks (see `config/schema/commercetools.schema.yml`).

## Routes (base module `commercetools.routing.yml`)

| Route | Path | Access | Notes |
|-------|------|--------|-------|
| `commercetools.settings` | `/admin/config/system/commercetools` | `administer site configuration` | `GeneralSettingsForm` (credentials, checkout mode, advanced). Two-step confirm when Client ID / project changes. |
| `commercetools.summary` | `…/summary` | `administer site configuration` | `SummaryController::view`. |
| `commercetools.settings_store` | `…/store` | `administer site configuration` | `StoreSettingsForm`. |
| `commercetools.subscriptions_settings` | `…/subscriptions` | `administer site configuration` | `SubscriptionSettingsForm` (SQS destination + webhook token + lambda template). |
| `commercetools.checkout_complete` | `/commercetools/checkout-complete` | `access content` | `CommercetoolsCheckoutController::checkoutComplete` — reads `orderId` (+ optional `destination`), fires `CommercetoolsOrderCreate`. |
| `commercetools.subscriptions_webhook` | `POST /api/commercetools/webhook/subscriptions` | custom (Bearer token = `webhook_token`) | `SubscriptionsController::call` — invalidates cache tags from the posted CT message body. `no_cache`, `_format json`. |

## Permission

`view own commercetools orders` (`commercetools.permissions.yml`) — gates the UI
submodules' own-order pages.

## Settings forms

- `GeneralSettingsForm` — connection creds + "Test Credentials" (uses
  `setOverriddenConfig`/`getProjectInfo`), checkout config, advanced (connection
  errors, request logging, cache TTL/clear, scope). Changing Client ID / Project
  key requires a confirmation step and dispatches `CommercetoolsConfigurationEvent`
  (migrates settings, clears cached carts/orders).
- `SubscriptionSettingsForm` — picks a cloud-messaging destination plugin (SQS
  shipped), sets the webhook token, and creates/updates/deletes the commercetools
  Subscription via `CommercetoolsSubscriptionsApi`. Shows a copy-paste AWS-lambda
  template that forwards events to the Drupal webhook with a Bearer token.

## Cache invalidation

- **Cron** (`CommercetoolsCron` → `CommercetoolsMessages`) polls commercetools
  **messages** and invalidates product/category/cart cache tags.
- **Subscriptions** (optional) — commercetools pushes change events to the webhook
  route, which invalidates the matching cache tags instantly (replaces cron).
- "Clear cache" button invalidates the general CT cache tag.
