<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# etsy.api service — EtsyService

`Drupal\etsy\EtsyService` (`src/EtsyService.php`), interface `Drupal\etsy\EtsyServiceInterface`. Registered as service **`etsy.api`** in `etsy.services.yml` with args `@http_client`, `@config.factory`, `@oauth2_client.service`, `@logger.channel.etsy`, `@cache.default`. Get it with `\Drupal::service('etsy.api')` or inject `etsy.api`.

Endpoint base: `const ENDPOINT = 'https://openapi.etsy.com/v3/application/'`. All calls are GET; the private `call()` throws for any other method. Responses are `json_decode()`'d to a `stdClass` (or an array of them). Reads shop id from `etsy.settings:shop_id`.

## Public methods (all return `mixed`/`object|bool`)

- `ping()` — GET `openapi-ping`; connectivity check.
- `getMe()` — GET `users/me`; authenticated user info.
- `shopInfo($key = NULL)` — GET `shops/{shop_id}`; if `$key` given, returns that property of the shop object (via `get_object_vars`), else the whole object.
- `getListingsByShop($limit = 25, $offset = 0, $includes = [], $state = NULL)` — GET `shops/{shop_id}/listings`. `$includes` must be an array (else throws) and is joined with commas (e.g. `Images`, `Videos`, `Shop`, `User`, `Inventory`, `Translations`, `Shipping` — see class constants). `$state` must be one of active/inactive/sold_out/draft/expired or throws (code 1001).
- `getListingById(int $listingId, $includes = [])` — GET `listings/{listingId}`.
- `getListingProperties($listingId)` — GET `shops/{shop_id}/listings/{listingId}/properties`.
- `getListingTransactions(int $listingId)` — GET `shops/{shop_id}/listings/{listingId}/transactions`.
- `getShopSections()` — GET `shops/{shop_id}/sections`.
- `getShopReceipts(int $receiptId = NULL, array $params = [])` — GET `shops/{shop_id}/receipts` or `.../receipts/{receiptId}`; `$params` becomes the query string.
- `getTaxonomy(string $type, int $taxonomy_id = 0)` — `$type` must be `buyer` or `seller` (else throws); GET `{type}-taxonomy/nodes` (or `.../nodes/{id}/properties`).

Class constants: `PRODUCT_STATE_*` (active/inactive/sold_out/draft/expired) and `INCLUDES_*` / `INCLUDE_*` (Shipping, Images, Shop, User, Translations, Inventory, Videos).

## Request building (`call($uri, $method='GET', $params=[])`)

1. Prepends `ENDPOINT` to `$uri`.
2. `$client = $this->oauthClient->getClient('etsy')` (oauth2_client service); `$access_token = $client->getAccessToken()`.
3. Headers: `x-api-key: {client->getClientId()}` and `Authorization: Bearer {access_token->getToken()}`.
4. For GET, `$params` becomes Guzzle `query`; `$this->httpClient->request('GET', $uri, $options)`. Uses the default Guzzle client — TLS certificate verification is on (no `verify => false`).
5. Success → `json_decode($response->getBody()->getContents())`. On any exception, returns a `stdClass` with an `->error` property = `$e->getMessage()`; callers detect failure by `isset($response->error)`.

## Caching

When `etsy.settings:cache_lifetime > 0`, `shopInfo`, `getListingsByShop`, `getListingById`, `getShopSections`, `getListingProperties` read/write `cache.default` under ids like `etsy:shop_info:{shop}`, `etsy:shop_listings:{shop}`, `etsy:listing:{id}`, `etsy:shop_sections:{shop}`, `etsy:listing_properties:{id}`. Expiry is set to `time() + cache_lifetime` (an absolute timestamp). `ping`, `getMe`, `getShopReceipts`, `getListingTransactions`, `getTaxonomy` are never cached. Note: `getListingsByShop` caches only when the response *contains* an error (a quirk of the source's branch), so successful listing responses are effectively not cached.

## Callers

- `hook_cron` in `etsy.module` calls `ping()` to keep the OAuth2 token alive.
- `EtsyTestForm` (admin) exercises every method.
- Etsy Shop submodule cron uses `getShopSections()` + `getListingsByShop(...)` to import nodes/terms.
