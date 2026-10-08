# Akamai services, header emission & token

Services (`akamai.services.yml`):

| Service | Class | Purpose |
|---|---|---|
| `akamai.client.factory` | `AkamaiClientFactory` | Returns the active `AkamaiClient` plugin (per `akamai.settings:version`). Entry point for programmatic purging. |
| `akamai.client.manager` | `AkamaiClientManager` | Plugin manager for the `akamai_client` type. |
| `akamai.key_provider` | `KeyProvider` | Wraps the optional `key.repository`; `hasKeyRepository()` / `getKeys()` used by the config form's key selects. |
| `akamai.cacheable_response_subscriber` | `EventSubscriber\CacheableResponseSubscriber` | Adds the `Edge-Cache-Tag` response header (when `edge_cache_tag_header` is on), honouring the blacklist. |
| `akamai.helper.cachetagformatter` | `Helper\CacheTagFormatter` | Normalises Drupal cache tags into header-safe values. |
| `akamai.helper.edgescape` | `Helper\Edgescape` | Reads Akamai Edgescape request headers; `getInformationByType($type)` powers the token. |
| `logger.channel.akamai` | LoggerChannel | The `akamai` log channel (used when `log_requests` is on). |

## Programmatic purge

```php
/** @var \Drupal\akamai\AkamaiClientInterface $client */
$client = \Drupal::service('akamai.client.factory')->get();
// $client->purgeUrls([...]) / purgeTags([...]) — see AkamaiClientInterface / AkamaiClientV3.
```

Purging respects `akamai.settings:disabled` (killswitch), `domain` (production/staging), and
`action_v3` (delete/invalidate).

## Token (`akamai.module`)

`hook_token_info()` + `hook_tokens()` add the `akamai` token type with a dynamic
`edgescape` token: `[akamai:edgescape:continent]`, `[akamai:edgescape:country_code]`, etc.
Values come from `akamai.helper.edgescape` and require `edgescape_support: TRUE`.

## Events

`Event\AkamaiPurgeEvents` and `Event\AkamaiHeaderEvents` let other modules alter purge
requests and the emitted headers.
