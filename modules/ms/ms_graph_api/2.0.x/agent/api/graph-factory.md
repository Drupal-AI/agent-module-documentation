<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Getting an authenticated Graph client

The whole point of the module: obtain a `Microsoft\Graph\Graph` from the official
`microsoft/microsoft-graph` SDK, already carrying an access token, so consuming code just makes
Graph requests.

## Two ways to get a client

**Default client** (uses the site's configured default Key — see
[../config/settings.md](../config/settings.md)):

```php
use Microsoft\Graph\Model;

$graph = \Drupal::service('ms_graph_api.graph');   // == factory->buildDefaultGraph()
$user = $graph->createRequest('GET', '/me')
  ->setReturnType(Model\User::class)
  ->execute();
```

Inject `ms_graph_api.graph` for the default client, or `ms_graph_api.graph.factory` when you need
a specific key. Note `ms_graph_api.graph` is built at container-build time via the factory, so it
requires a valid default key to be configured.

**Client for a specific key** (multi-tenant sites):

```php
$factory = \Drupal::service('ms_graph_api.graph.factory');
$graph = $factory->buildGraphFromKeyId('my_graph_api_key');
```

## The factory API — `GraphApiGraphFactory` implements `GraphApiGraphFactoryInterface`

File `src/GraphApiGraphFactory.php`, constructed with `@config.factory` + `@key.repository`.

| Method | Returns | Notes |
|---|---|---|
| `buildDefaultGraph()` | `Graph` | Resolves `default_key_id` from config, then `buildGraphFromKeyId()`. |
| `buildGraphFromKeyId(string $key_id)` | `Graph` | Loads the Key from the repository, then `buildGraphFromKey()`. |
| `buildGraphFromKey(KeyInterface $key)` | `Graph` | Reads `tenant_id`/`client_id`/`client_secret`, obtains a token, returns a `Graph` with the token set. |
| `getDefaultTenantDomain()` | `string` | Tenant domain from the default key. |
| `getTenantDomainFromKeyId(string $key_id)` | `string` | Tenant domain from a named key. |
| `getTenantDomainFromKey(KeyInterface $key)` | `string` | Tenant domain from a Key object. |

## What happens inside (token exchange)

`buildGraphFromKey()` calls `checkKeyType()` (must be a `GraphApiKeyType`, else
`ConfigValueException`), then `$key_type->unserialize($key->getKeyValue())` to get the multivalue
array. Each of `tenant_id`, `client_id`, `client_secret` is required — an empty one throws
`ConfigValueException`.

`obtainAccessToken($tenant_id, $client_id, $client_secret)`:
- Expands `MS_TOKEN_ENDPOINT_URI` =
  `https://login.microsoftonline.com/{tenant_id}/oauth2/token?api-version=1.0` via
  `GuzzleHttp\UriTemplate\UriTemplate::expand()`.
- POSTs with a **new `GuzzleHttp\Client`**, `form_params` =
  `client_id`, `client_secret`, `resource` (`https://graph.microsoft.com/`),
  `grant_type` = `client_credentials`. This is the OAuth 2.0 client-credentials (v1.0
  `/oauth2/token`) flow — server-to-server, **no user login, no redirect, no callback route**.
- On a Guzzle `RequestException` → `AccessTokenRequestException`
  (`src/Exception/AccessTokenRequestException.php`, a `RuntimeException`).
- Empty body → `AccessTokenParseException`
  (`src/Exception/AccessTokenParseException.php`, a `RuntimeException`).
- Otherwise `json_decode($body)->access_token` is returned; `$graph->setAccessToken(...)`.

The returned `Graph` is stateless w.r.t. Drupal — call any SDK method
(`createRequest()`, `setReturnType()`, `execute()`, etc.) as documented for
`microsoft/microsoft-graph`. Tokens are not cached: each `buildGraph*` call performs a fresh token
request.

## Constants worth citing

`Constants` (`src/Constants.php`): `MODULE_CONFIG_ID = ms_graph_api.settings`,
`CONFIG_KEY_DEFAULT_KEY_ID = default_key_id`, and the key-value field names
`tenant_domain` / `tenant_id` / `client_id` / `client_secret`.
