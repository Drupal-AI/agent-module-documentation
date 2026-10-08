# Bynder services

Two services (`bynder.services.yml`) plus a config-hash event subscriber.

## `bynder_api` → `Drupal\bynder\BynderApi` (interface `BynderApiInterface`)

Thin wrapper over the official `bynder/bynder-php-sdk` (`Bynder\Api\BynderClient`). It builds an SDK
configuration and returns an `AssetBankManager`, forwarding most calls via `__call()` (with caching for
some) and adding OAuth handling.

### Authentication (`getAssetBankManager()`)

Chooses configuration in this order:
1. An explicit config set via `setBynderConfiguration([...])` (used by the connection test) → permanent-token `Configuration`.
2. A valid **OAuth2** session token (`$session['bynder']['access_token']`) whose `config_hash` matches
   state `bynder_config_hash` → OAuth2 `Configuration`.
3. Otherwise the **permanent token** from `bynder.settings` (global).

### Key methods

| Method | Purpose |
|---|---|
| `initiateOAuthTokenRetrieval()` | Build the Bynder OAuth2 authorize URL (scopes: offline, asset read/write, usage read/write, current user/profile read). |
| `finishOAuthTokenRetrieval($code)` | Exchange the `code` for an access token; store it + `config_hash` in the session. |
| `hasAccessToken()` | True if a valid session OAuth token exists; refreshes an expired token or clears the session. |
| `hasUploadPermissions()` | Checks the Bynder user's security profile for `MEDIAUPLOAD`/`MEDIAUPLOADFORAPPROVAL`. |
| `getAssetBankManager()` | Returns the SDK asset-bank manager configured per above. |
| `getTags($query)` | Cached tag lookup (paginated); bypasses cache for `keyword` queries. |
| `addAssetUsage()/removeAssetUsage()/getAssetUsages()` | Bynder asset-usage CRUD (uses integration id). |
| `updateCachedData()` | Refresh cached metaproperties, derivatives, and the auto-updated tag queries. |
| `getIntegrationId()` | The fixed Bynder integration UUID (`a7129512-…`). |
| `__call($method,$args)` | Proxy any SDK method (e.g. `getBrands`, `getMediaList`, `getMediaInfo`, `getMetaproperties`, `getDerivatives`, `uploadFileAsync`); `getMetaproperties`/`getDerivatives` results are cached under `bynder_metaproperties` / `bynder_derivatives`. |

Caching: `cache.default` keyed `bynder_tags`/`bynder_metaproperties`/`bynder_derivatives`, TTL
`cache_lifetime`. `BynderConfigHashGenerator` (event subscriber) maintains state `bynder_config_hash` so
that changing global config invalidates all users' OAuth sessions.

## `bynder` → `Drupal\bynder\BynderService` (interface `BynderServiceInterface`)

Higher-level operations over media entities:

| Method | Purpose |
|---|---|
| `updateLocalMetadataCron()` | Refresh metadata for up to `MAX_ITEMS` local media each cron. |
| `getBynderMediaTypes()` | All media types whose source is `bynder`. |
| `getTotalCountOfMediaEntities()` | Count of Bynder media (for the batch). |
| `updateMetadataLastMediaEntities($minimum_id, $limit)` | Refresh the next N media (batch worker). |
| `updateMediaEntities(array &$entities)` | Refresh a given set (used by `bynder_sns`). |

## Calling from code

```php
$api = \Drupal::service('bynder_api');
$brands = $api->getBrands();
$info   = $api->getMediaInfo($asset_id, 1);
$tags   = $api->getTags(['keyword' => 'logo', 'limit' => 25, 'minCount' => 1]);

\Drupal::service('bynder')->updateLocalMetadataCron();
```
