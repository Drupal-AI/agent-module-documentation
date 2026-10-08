<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Trustpilot API (trustpilot_api) — agent index

A thin **HTTP client service** for the [Trustpilot API](https://documentation-apidocumentation.trustpilot.com/),
exposed as `trustpilot_api.client`. It is a developer tool, not a site-builder feature: it ships **no
blocks, fields, formatters, or display of any kind**. You call `->request($endpoint, $params)` from
your own code (or from the bundled admin **Test** forms) and get back the decoded-JSON response as a
PHP array. Each Trustpilot endpoint is an **annotation plugin** (`@Endpoint`, type
`Plugin/TrustpilotApi/Endpoint`); the module bundles 26 of them (public "key"-auth review/category
endpoints plus a few OAuth-authenticated `private/*` ones). The client sends the API key as an
`apiKey` request header (base URI `https://api.trustpilot.com/v1/`), and for `authType = oauth`
endpoints it performs the Trustpilot password-grant token exchange, caches the access token in
`cache.default`, refreshes it, and appends it as a `?token=` query param.

- Depends on: nothing outside core (no `dependencies` in info.yml; no `composer.json`).
- Core: `^8.8 || ^9 || ^10 || ^11`. Package: `Web services`. Version `1.0.1`.
- Settings page: `trustpilot_api.settings` (`/admin/config/services/trustpilot-api`), gated by core
  **`administer site configuration`** — the module defines **no permissions of its own**. Provides
  config schema. No drush, no hooks besides `hook_help`, no cron, no theme/library/JS/CSS.
- Defines one plugin type: **`Endpoint`** (manager service `trustpilot_api.endpoint_plugin_manager`,
  annotation `Drupal\trustpilot_api\Annotation\Endpoint`, base `EndpointPluginBase`, alter hook
  `trustpilot_api_endpoint_info`).

## What you'd do → where

- **Set the API key / secret / OAuth login, or override them in settings.php; configure logging &
  timeout** → [configure/settings.md](configure/settings.md)
- **Call the client from code: get the service, pick an endpoint, `request()`, OAuth/caching flow** →
  [api/client.md](api/client.md)
- **Add a new Trustpilot endpoint, or list the 26 bundled ones and their params** →
  [plugins/endpoint.md](plugins/endpoint.md)

## Key facts (real machine names)

- Service: `trustpilot_api.client` (`Drupal\trustpilot_api\TrustpilotApiClient`, implements
  `TrustpilotApiClientInterface`). Public methods: `getHttpClient()`, `getEndpointPluginManager()`,
  `request(EndpointPluginInterface $endpoint, array $params = [])`, `canAuthorizePrivate(): bool`.
- Plugin manager service: `trustpilot_api.endpoint_plugin_manager`
  (`EndpointPluginManager extends DefaultPluginManager`), discovers `Plugin/TrustpilotApi/Endpoint`.
- Plugin type: annotation `@Endpoint` (`…\Annotation\Endpoint`), interface `EndpointPluginInterface`,
  base `EndpointPluginBase`; annotation props: `id`, `name`, `path`, `method` (default `GET`),
  `authType` (`key` | `oauth`, default `key`), `documentationUrl`, `requiredParams`,
  `defaultRequestParams`, `headers`.
- Routes (all `_permission: administer site configuration`): `trustpilot_api.settings`
  (`/admin/config/services/trustpilot-api`, `Form\SettingsForm`), `trustpilot_api.test`
  (`…/test`, `Form\TestForm`), `trustpilot_api.test_endpoint`
  (`…/test/endpoint/{endpoint_id}`, `Form\TestEndpointForm`).
- Config object `trustpilot_api.settings` keys: `api_key`, `api_secret`, `oauth_email`,
  `oauth_password`, `business_unit_id`, `logging_enabled` (bool, default `false`),
  `client_connect_timeout` (float, default `0`). (`api_secret` has schema + form fields but no
  install default.)
- OAuth token object: `Drupal\trustpilot_api\OAuthToken` (interface `OAuthTokenInterface`), cached
  under cid `trustpilot_api.oauth_access_token`; token exchange URL
  `https://api.trustpilot.com/v1/oauth/oauth-business-users-for-applications/accesstoken`.
- Bundled endpoint plugin ids (26): `business_unit_categories`, `business_unit_company_logo`,
  `business_unit_customer_guarantee`, `business_unit_images`, `business_unit_legacy_all`,
  `business_unit_legacy_find`, `business_unit_legacy_list`, `business_unit_legacy_public_info`,
  `business_unit_legacy_web_links`, `business_unit_private_reviews` (oauth),
  `business_unit_profile_info`, `business_unit_profile_promotion`, `business_unit_reviews`,
  `business_unit_search`, `categories_business_units`, `categories_get`, `categories_list`,
  `consumer_profile_get`, `consumer_profile_list` (POST), `consumer_profile_reviews`,
  `consumer_reviews`, `private_products_get` (oauth), `private_products_upsert` (oauth, POST),
  `product_reviews_get_imported`, `product_reviews_get_imported_summaries`,
  `product_reviews_summaries` (POST).
- Exceptions: `Exception\EndpointRequiredOptionsMissing`, `Exception\RequestOAuthAccessTokenFailed`.
