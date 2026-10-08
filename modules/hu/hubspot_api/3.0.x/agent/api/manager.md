<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Using the HubSpot client (services)

The module exposes two services (`hubspot_api.services.yml`). Consuming code should depend on
`hubspot_api.manager` and call `getHandler()`.

## `hubspot_api.manager` → `Drupal\hubspot_api\Manager`

Implements `Drupal\hubspot_api\ManagerInterface`. Constructor args:
`@config.factory`, `@logger.factory`, `@hubspot_api.oauth`, `@state`.

| Method | Returns | Behaviour |
|---|---|---|
| `getHandler()` | `?HubSpot\Discovery\Discovery` | Tries `getHandlerWithOauth()`; if null, falls back to `getHandlerWithAccessToken()` (Private App token). Returns null when neither is configured. |
| `getHandlerWithOauth()` | `?HubSpot\Discovery\Discovery` | Reads State `hubspot_api_tokens`; null if no `access_token`. If the token is within ~15 min of its stored `expire_date` (HubSpot tokens last 6 h), it refreshes first via `OAuth::getTokensByRefresh()`. Returns `Factory::createWithAccessToken($accessToken)`. |
| `getHandlerWithAccessToken(?string $token = NULL)` | `?HubSpot\Discovery\Discovery` | Uses `$token`, else config `hubspot_api.settings:access_key`. Null if none. Returns `Factory::createWithAccessToken($token)`. |

`getHandler()` returns the SDK's `Discovery` object, from which every HubSpot API namespace is
reachable (`->crm()`, `->contacts()`, `->companies()`, `->deals()`, `->files()`, …).

### Example

```php
/** @var \Drupal\hubspot_api\ManagerInterface $manager */
$manager = \Drupal::service('hubspot_api.manager');   // or inject the service
$handler = $manager->getHandler();
if ($handler) {
  // Legacy contacts endpoint (as in README):
  $contacts = $handler->contacts()->all(['count' => 10, 'property' => ['firstname', 'lastname']]);
  // CRM v3 example:
  // $page = $handler->crm()->contacts()->basicApi()->getPage();
}
```

Drush smoke test (from README.md):

```bash
drush ev '$m=\Drupal::service("hubspot_api.manager"); $h=$m->getHandler(); print json_encode($h->contacts()->all(["count"=>10,"property"=>["firstname","lastname"]]));'
```

## `hubspot_api.oauth` → `Drupal\hubspot_api\Services\OAuth`

Constructor args: `@config.factory`, `@http_client`, `@logger.factory`, `@state`. Usually driven by
the settings form / callback, not called directly.

| Method | Purpose |
|---|---|
| `getTokensByCode(string $code): ?TokenResponseIF` | Exchanges an authorization `code` for tokens using the site's `client_id`/`client_secret` and the `hubspot_api.oauth_redirect` redirect URI. Logs and returns null on failure. |
| `getTokensByRefresh(): ?string` | Uses the stored `refresh_token` to mint a new access token, calls `saveTokens()`, returns the new access token string. |
| `saveTokens(TokenResponseIF $tokens): void` | Writes `['access_token','refresh_token','expire_date' => getExpiresIn()+time()]` to State `hubspot_api_tokens`. |

All SDK calls go through `HubSpot\Factory` (the official `hubspot/api-client`), which uses its own
Guzzle client. Errors are caught and written to the `hubspot_api` logger channel.

## Notes

- `getHandler()` can return **null** — always guard before calling methods on it.
- The manager reads OAuth tokens from **State**, and the Private App token from **config**; changing
  credentials in the settings form takes effect immediately (no cache rebuild needed).
- There are no plugins, events, or hooks to implement — integrate purely by calling the service.
