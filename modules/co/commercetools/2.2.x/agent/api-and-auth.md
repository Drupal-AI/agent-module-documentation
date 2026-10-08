<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# commercetools — API service & OAuth2 auth

`src/CommercetoolsApiService.php` (service `commercetools.api`, interface
`CommercetoolsApiServiceInterface`). The single gateway to commercetools; wraps
`commercetools/commercetools-sdk` (`ApiRequestBuilder`, OAuth2 middlewares).

## OAuth2 client credentials

- `getAuthHandler(scope)` builds `Commercetools\Client\ClientCredentials` from
  `client_id` + `client_secret` (from the `commercetools.api` config via
  `CommercetoolsConfiguration::getConnectionConfig()`).
- Scope handling: the configured `scope` (space-separated) is expanded to append
  the project key to each scope — `"{$scope}:{$project_key}"` — as commercetools
  requires. Handler built by `OAuthHandlerFactory::ofAuthConfig()` with a
  PSR-16 cache (`commercetools.psr_cache_adapter`, backed by Drupal `cache.default`)
  so the access token is reused until expiry.
- `resetConnection()` clears that token cache and the Guzzle client;
  `setOverriddenConfig()` / `restoreOriginalConfig()` let the settings form test
  temporary credentials (see `GeneralSettingsForm::testCredentials()`).

## Hosts (fixed)

`getApiUrl($type)` — host = `<hosted_region>.commercetools.com` (constant
`COMMERCETOOLS_API_HOST = 'commercetools.com'`):
- `api` → `https://api.<region>.commercetools.com`
- `auth` → `https://auth.<region>.commercetools.com/oauth/token`
- `session` → `https://session.<region>.commercetools.com`

`<region>` is one of a fixed select list (us-central1.gcp, us-east-2.aws,
europe-west1.gcp, eu-central-1.aws, australia-southeast1.gcp). Always HTTPS.

## HTTP client

`getClient()` builds a Guzzle client via Drupal `http_client_factory->fromOptions()`
using the SDK `Config` options plus SDK default middlewares
(`MiddlewareFactory::createDefaultMiddlewares`) with the OAuth handler pushed onto
the handler stack. The `commercetools` logger is attached to the middleware **only
when** `commercetools.settings:log_commercetools_requests` is true (default false).

## GraphQL execution & caching

`executeGraphQlOperation($query, $variables, $cacheMetadata)`:
1. Resolves cache max-age from `commercetools.api:cache_responses_ttl`
   (`-1` = permanent/no auto-expire, `0` = caching off, N = N seconds).
2. Dispatches `CommercetoolsGraphQlOperationEvent` (subscribers may rewrite
   `$variables`, set cache metadata, or set `operationAllowed=FALSE` → throws
   `CommercetoolsGraphqlAccessException`). Token placeholders like
   `[current_cart:id]`, `[current_customer:id]`, `[order_number]` in variables are
   replaced here by `CommercetoolsGraphQlOperationTokensSubscriber`.
3. Cache lookup (`cache.default`, key = sha1 of query+variables+builder args).
4. Runs `builder->graphql()->post(...)`; on API errors throws
   `CommercetoolsGraphqlErrorException`; empty data →
   `CommercetoolsOperationFailedException`.
5. Dispatches `CommercetoolsGraphQlOperationResultEvent` (subscribers may alter or
   access-check the result), then caches with the resolved tags/expiry.

`getProjectInfo()` fetches project key/name/countries/currencies/languages +
customerGroups, channels, stores (used by "Test Credentials" and store settings).

## Response wrappers

`CacheableCommercetoolsGraphQlResponse` / `CacheableCommercetoolsResponse` carry
`getData()` + Drupal cacheable metadata (cache tags such as product/category/cart
prefixes) so renders invalidate correctly.
