<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ApiClient — LWA auth & SP-API methods

Service `commerce_amazon_sp_api.client` = `Amazon/ApiClient`. Injected: core `http_client`
(Guzzle), `event_dispatcher`, `datetime.time`, `extension.list.module`. All requests go over HTTPS
with Guzzle's default TLS verification (no verification override).

## LWA authentication (no AWS SigV4)

SP-API here uses **Login-with-Amazon** access tokens only — there is no AWS SigV4 request signing
(the module sends the token in a header, which Amazon accepts for these APIs).

- `refreshAccessToken(AmazonApp)` — POSTs to `AMAZON_AUTH_TOKEN_URL`
  (`https://api.amazon.com/auth/o2/token`) with `form_params`:
  `grant_type=refresh_token`, `refresh_token`, `client_id`, `client_secret`. Stores the returned
  `access_token`, rotated `refresh_token`, and `expires_in` (current time + expiry − 60s) on the
  App, then calls `getMarketplaceParticipations()` to refresh the App's `marketplaces` list, and
  saves the App.
- `getAccessToken(AmazonApp)` — returns the cached token if `now < expires_in`, else calls
  `refreshAccessToken()` first. Called by every `apiCall()`.

## `apiCall($endpoint, AmazonMarketplace|AmazonApp, $payload = [], $method = 'GET')`

Central helper. Resolves the App (directly, or via the marketplace), builds the base URL from
`AmazonApp::getEndpointByRegion()`, and sends the request with headers:
`Content-Type: application/json`, `x-amz-access-token: {LWA token}`, `x-amz-date`, and a
`user-agent` naming the Commerce version + PHP version. In **sandbox** mode it also adds
`x-amzn-sandbox: true` and an `x-amzn-idempotency-token`. `$payload` is sent as Guzzle `json`.
On a `GuzzleException` it formats Amazon's `errors[]` (`formatErrorMessages()`), logs them, and
throws `Exception/AmazonApiException` (carrying the parsed errors + HTTP code). When the App's
`logging` flag is on, the response body is logged at info level. Returns the JSON-decoded body.

## SP-API methods (all route through `apiCall`)

**FBA Inventory (v1)**
- `getInventorySummaries(marketplace, $startDateTime = NULL, $nextToken = NULL)` — paginated
  summaries for the marketplace (incremental sync passes `startDateTime`, offset −900s).
- `getInventorySummariesByItem(item)` — single-SKU summary.
- `createInventoryItem(item)`, `addInventory(item)` — **sandbox-only** (return `[]` in production).

**Fulfillment Outbound (v2020-07-01)**
- `createFulfillmentOrder(marketplace, $payload)` (POST)
- `getFulfillmentOrder(fulfillment)` / `cancelFulfillmentOrder(fulfillment)` /
  `listAllFulfillmentOrders(marketplace)`
- `getFulfillmentPreview(marketplace, $payload)` (POST), `getDeliveryOffers(marketplace, $payload)` (POST)
- `submitFulfillmentOrderStatusUpdate(fulfillment, $status)` (PUT) — **sandbox-only** (used to
  simulate status transitions in testing).

**Sellers (v1)**
- `getMarketplaceParticipations(app)` — active marketplaces under the account.

**Listings / Product Types (partial, not wired into Commerce UI)**
- `putListingsItem(item)` (POST, dispatches `AMAZON_PUT_LISTINGS` to alter payload),
  `getListingItem(item)`, `searchDefinitionsProductTypes(marketplace)`,
  `getDefinitionsProductType(marketplace, $productType)`.

Rate limiting: the inventory sync loop (`Amazon/Inventory`) `sleep(1)`s between paged calls to stay
under Amazon's ~2 req/s cap.
