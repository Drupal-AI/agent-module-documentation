<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Gateway client, request options, endpoint styles & model catalogue

## GatewayClient (`src/GatewayClient.php`)

Service `Drupal\cloudflare_ai_gateway\GatewayClient` (autowired), aliased to
`GatewayClientInterface`. Pure URL/header construction over the SDK's
`CloudflareHttpClientFactoryInterface` — it builds Guzzle clients bound to a gateway endpoint; it
does not itself run LLM requests. Constructor deps: the HTTP client factory,
`cloudflare_sdk` `CredentialResolverInterface`, and the entity type manager.

Methods:

- `buildBaseUri(GatewayInterface $gateway, EndpointStyle $style, string $accountId, ?string $provider = NULL): string`
  Base is `rtrim(host,'/')/v1/{accountId}/{gateway_slug}`, then per style:
  - `Universal` → base (provider named in the request body)
  - `OpenAiCompat` → base `/compat`
  - `Passthrough` → base `/{provider}` where `$provider` falls back to
    `$gateway->getDefaultProvider()`.
- `resolveCredentials(GatewayInterface $gateway): CloudflareCredentials`
  Loads the `cloudflare_credentials` entity named by `getCredentialsId()`; throws
  `CloudflareApiException` if missing, else resolves it via the SDK credential resolver (secret
  comes from settings.php/env). Yields `apiToken` + `accountId`.
- `buildRequestHeaders(CloudflareCredentials $credentials, GatewayRequestOptions $options): array`
  Returns `['cf-aig-authorization' => 'Bearer ' . $credentials->apiToken] + $options->toHeaders()`.
  The gateway's own authorization is this `cf-aig-authorization` header (distinct from the
  upstream provider auth, which the caller adds).
- `createClient(GatewayInterface $gateway, EndpointStyle $style, ?string $provider = NULL, ?GatewayRequestOptions $options = NULL): ClientInterface`
  Resolves credentials, builds the base URI (with trailing `/`) and headers, returns a Guzzle
  client from the factory.
- `listModels(GatewayInterface $gateway): array`
  Creates an `OpenAiCompat` client, `GET models`, decodes `data[]` into
  `[{id, owned_by, cost_in, cost_out}]` (non-string/non-numeric fields are dropped/nulled). This
  is the union of models across every provider the gateway fronts.

## GatewayRequestOptions (`src/GatewayRequestOptions.php`)

Immutable `readonly` value object mapping to `cf-aig-*` request headers. Constructor params
(all optional): `cacheTtl` (int|null), `skipCache` (bool), `metadata` (array), `cacheKey`
(string|null). Fluent copies: `withCacheTtl()`, `withSkipCache()`, `withMetadata()`,
`withCacheKey()`. `toHeaders()` emits only set values:

| option | header | value |
|--------|--------|-------|
| `cacheTtl` | `cf-aig-cache-ttl` | seconds (string) |
| `skipCache` | `cf-aig-skip-cache` | `true` (only if set) |
| `metadata` | `cf-aig-metadata` | `json_encode(..., JSON_THROW_ON_ERROR)` (only if non-empty) |
| `cacheKey` | `cf-aig-cache-key` | the key |

## EndpointStyle (`src/Endpoint/EndpointStyle.php`)

String enum of the gateway's addressing styles: `Passthrough` (`passthrough`, provider-specific,
e.g. `/{provider}/v1/chat/completions`), `Universal` (`universal`, single endpoint, provider in
the body), `OpenAiCompat` (`openai_compat`, e.g. `/compat/chat/completions` and `/compat/models`).

## ModelCatalogue (`src/ModelCatalogue.php`)

Service with args `GatewayClientInterface`, `cache.default`, `datetime.time`. `getModels(gateway)`
returns `GatewayClient::listModels()` cached per gateway under
`cloudflare_ai_gateway:models:{id}` for `TTL = 3600` seconds. Used by admin autocomplete /
screens because a gateway can front thousands of models.
