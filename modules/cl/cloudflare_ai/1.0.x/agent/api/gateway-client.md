<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Gateway client, endpoint styles, request options & model catalogue

The AI Gateway is a hosted reverse proxy: every endpoint style is just a base URI on
`gateway.ai.cloudflare.com` plus `cf-aig-*` control headers. So `GatewayClient` is **pure
URL/header construction** over the SDK's shared HTTP client factory — it does not itself perform
inference calls; it hands back a configured Guzzle `ClientInterface` for callers (e.g.
`ai_provider_cloudflare_gateway`) to drive.

## `GatewayClient` (service `Drupal\cloudflare_ai\GatewayClient`, iface `GatewayClientInterface`)

Autowired. Constructor deps: `CloudflareHttpClientFactoryInterface` (from `cloudflare_sdk`),
`CredentialResolverInterface`, `EntityTypeManagerInterface`.

- **`buildBaseUri(GatewayInterface $gateway, EndpointStyle $style, string $accountId, ?string $provider = NULL): string`**
  builds `{host}/v1/{accountId}/{gateway_slug}` then appends per style:
  - `Universal` → base (provider named in the request body)
  - `OpenAiCompat` → `…/compat`
  - `Passthrough` → `…/{provider}` (falls back to the gateway's `default_provider`)
  The host is the admin-configured `getHost()` (rtrim'd); the account ID is resolved from the
  credential set, not taken from a request.
- **`buildRequestHeaders(CloudflareCredentials $credentials, GatewayRequestOptions $options): array`**
  returns `['cf-aig-authorization' => 'Bearer ' . $credentials->apiToken]` merged with
  `$options->toHeaders()`. The gateway authorization token is the credential set's token.
- **`resolveCredentials(GatewayInterface $gateway): CloudflareCredentials`** loads the
  `cloudflare_credentials` entity by `getCredentialsId()` and resolves it via the SDK resolver;
  throws `CloudflareApiException` if the referenced set is missing (and the SDK's
  `MissingCredentialException` if the secret can't be resolved).
- **`createClient(GatewayInterface $gateway, EndpointStyle $style, ?string $provider = NULL, ?GatewayRequestOptions $options = NULL): ClientInterface`**
  resolves credentials, builds the base URI (with a trailing `/`) and the headers, and returns a
  client from the SDK factory. `$options` defaults to a fresh `GatewayRequestOptions()`.
- **`listModels(GatewayInterface $gateway): array`** GETs `models` on the OpenAi-compat client and
  returns `[{id, owned_by, cost_in, cost_out}]` for each entry with a string `id`. This is the
  union of models across every provider the gateway fronts (can be thousands).

## `EndpointStyle` enum (`Endpoint/EndpointStyle`)

`Passthrough = 'passthrough'`, `Universal = 'universal'`, `OpenAiCompat = 'openai_compat'`. See
`buildBaseUri` above for how each maps to a URL suffix.

## `GatewayRequestOptions` (`GatewayRequestOptions`)

`final readonly` immutable value object mapping to `cf-aig-*` request headers. Constructor +
`with*` copy methods:

| property | header | `toHeaders()` emits |
|----------|--------|---------------------|
| `?int $cacheTtl` | `cf-aig-cache-ttl` | when non-null, as string |
| `bool $skipCache` | `cf-aig-skip-cache` | `'true'` when true |
| `array $metadata` | `cf-aig-metadata` | `json_encode(..., JSON_THROW_ON_ERROR)` when non-empty |
| `?string $cacheKey` | `cf-aig-cache-key` | verbatim when non-null |

`withCacheTtl`, `withSkipCache`, `withMetadata`, `withCacheKey` each return a new instance;
`toHeaders()` returns only the set keys (empty array when nothing is set).

## `ModelCatalogue` (service `Drupal\cloudflare_ai\ModelCatalogue`)

Wraps `GatewayClientInterface::listModels()` with a cache (`cache.default`, `datetime.time`).
`getModels(GatewayInterface)` reads/writes `cache:'cloudflare_ai:models:'.$gateway->id()` with a
**3600s** TTL (`getRequestTime() + TTL`). Used to keep admin autocomplete/screens fast. Returns
the same `[{id, owned_by, cost_in, cost_out}]` shape as `listModels`.
