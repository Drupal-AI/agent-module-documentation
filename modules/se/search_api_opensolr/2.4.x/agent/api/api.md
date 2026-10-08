<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# opensolr API service layer

All opensolr HTTP calls funnel through `OpenSolrBase` (`src/OpenSolrApi/OpenSolrBase.php`). Component
services extend it (abstract parent `search_api_opensolr.base`, wired with the Guzzle client, JSON
serializer, the `OpenSolrConfig` service, file URL generator, and the module logger).

## `OpenSolrBase`

- `const OPENSOLR_ENDPOINT_URL = 'https://opensolr.com/solr_manager/api'` — hardcoded base URL (not
  config-overridable). Guzzle TLS verification is left at its secure default.
- `protected apiCall($path, $method='GET', $params=[], $returnObject=FALSE, $useMultipart=FALSE, $attachApiCredentials=TRUE)`
  — builds the request. By default it merges the stored API credentials into `$params`; JSON body for
  non-multipart, query string for GET. File params are sent multipart (`attachMultipart()`).
- `protected buildErrorResponse(\Exception $e)` — turns any failure (network error, HTTP 4xx/5xx, non-JSON
  body) into a well-formed `OpenSolrResponse` with `status=false` instead of letting it fatal the admin
  page. Prefers the API's own JSON error body when present; otherwise maps non-HTTP codes to 503. Logs the
  message **after** running it through `OpenSolrResponse::redactCredentials()`.

Return shape: `apiCall()` returns the decoded array (always an array, possibly empty) unless
`$returnObject=TRUE`, in which case it returns the `OpenSolrResponse` object.

## `OpenSolrResponse` — `src/OpenSolrApi/OpenSolrResponse.php`

Wraps the Guzzle response, JSON-decodes the body into `$data` (always an array; `[]` for empty), and
exposes `isSuccess()`, `getFullResponseData()`, `getResponseData($key='msg')`. Invalid JSON throws
`OpenSolrException`. **`static redactCredentials($text, $params=['email','api_key','username','password'])`**
replaces those query-parameter values with `XXX` — used everywhere a URL/message is logged or shown,
since credentials travel as GET params and Guzzle embeds the full URL in exception text.

## Component services

| Service id | Class | Key methods |
|---|---|---|
| `search_api_opensolr.client_index` | `OpenSolrIndex` | `getIndexList()`, `getCoreInfo($core)`, `getCoreStatus`, `reloadCore`, `optimizeCore`, `commitData`, `createCore($core,$region)`, `deleteCore`, `replicateIndex($core,$target)`, `getEnvironments()` |
| `search_api_opensolr.client_config_files` | `OpenSolrConfigFiles` | `getAllConfigFiles($core)`, `uploadZipConfigFiles($core,$zip)`, `uploadConfigFile($core,$file)`, `deleteConfigFile($core,$name,$ext)` |
| `search_api_opensolr.config` | `OpenSolrConfig` (not a base child) | `getApiCredentials()`, `extractApiCredentials()`, `getEmail/setEmail`, `getApiKey/setApiKey` — see [../configure/settings.md](../configure/settings.md) |
| `search_api_opensolr.client_security` (submodule) | `OpenSolrSecurity` | `updateHttpAuth`, `removeHttpAuth`, `getIpList`, `addIp`, `removeIp` |

> **Removed in 2.4.x:** the `OpenSolrAccount` component and its `search_api_opensolr.account` service
> (account registration `sendEmailCode` / `createAccount`). Accounts are now created on opensolr.com only;
> the Get started page is a guide, not a registration form.

## Using a component

```php
/** @var \Drupal\search_api_opensolr\OpenSolrApi\Components\OpenSolrIndex $index */
$index = \Drupal::service('search_api_opensolr.client_index');
$cores = $index->getIndexList();          // account's cores
$info  = $index->getCoreInfo('my_core');  // connection_url, auth, size, bandwidth
$index->optimizeCore('my_core');
```

Credentials are attached automatically from `search_api_opensolr.opensolrconfig`, so the service is only
usable once an admin has configured the email + API key.
