<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# opensolr API service layer

All opensolr HTTP calls funnel through `OpenSolrBase` (`src/OpenSolrApi/OpenSolrBase.php`). Component
services extend it (abstract parent `search_api_opensolr.base`, wired with the Guzzle client, JSON
serializer, the `OpenSolrConfig` service, file URL generator, and the module logger).

## `OpenSolrBase`

- `const OPENSOLR_ENDPOINT_URL = 'https://opensolr.com/solr_manager/api'` — hardcoded base URL.
- `protected apiCall($path, $method='GET', $params=[], $returnObject=FALSE, $useMultipart=FALSE, $attachApiCredentials=TRUE)`
  — builds the request. By default it merges the stored API credentials into `$params`; JSON body for
  non-multipart, query string for GET. File params are sent multipart (`attachMultipart()`). Exceptions
  are logged and wrapped in an `OpenSolrResponse` with `status=false`.

## Component services

| Service id | Class | Key methods |
|---|---|---|
| `search_api_opensolr.client_index` | `OpenSolrIndex` | `getIndexList()`, `getCoreInfo($core)`, `getCoreStatus`, `reloadCore`, `optimizeCore`, `commitData`, `createCore($core,$region)`, `deleteCore`, `replicateIndex($core,$target)`, `getEnvironments()` |
| `search_api_opensolr.client_config_files` | `OpenSolrConfigFiles` | `getAllConfigFiles($core)`, `uploadZipConfigFiles($core,$zip)`, `uploadConfigFile($core,$file)`, `deleteConfigFile($core,$name,$ext)` |
| `search_api_opensolr.account` | `OpenSolrAccount` | `sendEmailCode($email)`, `createAccount($email,$code,$password)` (registration; called with `attachApiCredentials=FALSE`) |
| `search_api_opensolr.config` | `OpenSolrConfig` (not a base child) | `getApiCredentials()`, `getEmail/setEmail`, `getApiKey/setApiKey` — see [../configure/settings.md](../configure/settings.md) |

Responses are `OpenSolrResponse` objects (`src/OpenSolrApi/OpenSolrResponse.php`); `OpenSolrException`
signals API errors. `OpenSolrErrors` holds error-code helpers.

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
