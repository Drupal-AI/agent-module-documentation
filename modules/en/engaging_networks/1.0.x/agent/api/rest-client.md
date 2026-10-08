<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# REST API client service

## Service

`engaging_networks.services.yml` registers **`engaging_networks.rest_api`** →
`Drupal\engaging_networks\RestApi` with arguments `@config.factory`, `@key.repository`, `@state`.

`RestApi` (`src/RestApi.php`, `final`) constructor:
- Reads immutable config `engaging_networks.rest_api`.
- Builds a library `OpenPublicMedia\EngagingNetworksServices\Rest\Client` with:
  - `endpoint` config → base URI,
  - `keyRepository->getKey($config->get('api_key'))->getKeyValue()` → the ENS API key (the config stores the
    **Key entity id**, not the secret; the value is resolved from the Key module at runtime),
  - `cache: $config->get('cache_enable') ? $this->state : NULL` → passes Drupal `@state` as the token cache,
  - `cache_key_token` / `cache_key_token_expire` from `config.cache_keys.token` / `.expire`.

`getClient(): Client` returns that client. That is the module's entire public surface.

## Usage from custom code

```php
/** @var \Drupal\engaging_networks\RestApi $restApi */
$restApi = \Drupal::service('engaging_networks.rest_api');
$page = $restApi->getClient()->getPage(1234);
```

Prefer constructor injection of the `engaging_networks.rest_api` service in real code.

## Client methods (library `Client.php`, `~0.10`)

Auth is automatic: `Client::request()` calls the private `getToken()` for every non-`authenticate` endpoint,
POSTing the API key to `authenticate`, reading `ens-auth-token`/`expires`, and sending it as the
`ens-auth-token` header. When state caching is on, the token + expiry are stored under the configured cache keys
and reused until within 300s of expiry.

- `getPages(PageType $type, ?PageStatus $status = null): Page[]`
- `getPage(int $id): Page`
- `processPage(int $id, array $payload): PageRequestResult` — submits a page request (donation/advocacy action).
- `getSupporterById(int $id, bool $withMemberships = false, bool $withQuestions = false): Supporter`
- `getSupporterByEmailAddress(string $email, bool $withMemberships = false, bool $withQuestions = false): Supporter`
- `addOrUpdateSupporter(string $email, ?array $fields = []): int` — upsert; returns supporter id.
- `getSupporterFields(): array<string, SupporterField>`
- `getSupporterQuestions(): array<int, SupporterQuestion>` / `getSupporterQuestion(int $id): SupporterQuestion`
- Low-level `get()` / `post()` return decoded JSON.

## Errors

The library maps HTTP `204`/`404` → `NotFoundException`, other non-`200` → `RequestException`, and wraps
Guzzle transport errors in `RuntimeException`. Callers should catch these.

## Transport

The client uses a Guzzle `Client` created with `base_uri` and `http_errors => false` only; the Drupal wrapper
passes no extra HTTP options, so Guzzle defaults apply (including certificate verification). Data flow is
outbound Drupal → ENS; no inbound route is registered.
