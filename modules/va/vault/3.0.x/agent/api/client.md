# API — Vault client, config, cache

## Services

| Service id | Class | Notes |
|------------|-------|-------|
| `vault.vault_client` | `Drupal\vault\VaultClient` | Primary client. Built by the factory **with** lease storage; authenticates on creation (throws `Vault\Exceptions\AuthenticationException` if no auth plugin / auth fails). |
| `vault.vault_client_no_lease_storage` | `Drupal\vault\VaultClient` | Same client without lease storage; used internally by lease-storage plugins to avoid recursion. |
| `vault.config` | `Drupal\vault\VaultConfig` (`VaultConfigInterface`) | Typed reader over `vault.settings` (see configure/settings.md). |
| `vault.cache.manager` | `Drupal\vault\VaultCacheManager` | `clearCache()`, `pruneCache()` over the private `vault.cache` pool. |
| `plugin.manager.vault_auth` | `VaultAuthManager` | Auth-strategy plugin manager (plugins/auth.md). |
| `plugin.manager.vault_lease_storage` | `VaultLeaseStorageManager` | Lease-storage plugin manager (plugins/lease-storage.md). |
| `logger.channel.vault` | logger channel | Decorated by `vault.channel.filter` (`VaultLogLevelFilter`); minimum level = parameter `vault.logger.level` (default `warning`), so lower-severity messages from the vault-php library are dropped. |

`vault.vault_client_factory` (`VaultClientFactory`, private) builds the client: constructs a
`VaultClient` from `base_url` + Drupal's `@http_client`, enables read caching when
`read_cache_ttl != 0`, sets the cache pool, sets the lease-storage plugin (primary client only),
then creates the configured auth plugin, applies its `AuthenticationStrategy`, and calls
`authenticate()`.

## Getting the client

```php
/** @var \Drupal\vault\VaultClientInterface $client */
$client = \Drupal::service('vault.vault_client');
```

Constant: `VaultClient::API === 'v1'`. `buildPath($path)` prefixes the API version, e.g.
`buildPath('/secret/data/foo')` → `/v1/secret/data/foo`.

## Reading / writing secrets

`VaultClient` extends `Vault\CachedClient`; the wire methods come from `VaultPhpInterface`
(the vault-php SDK). Paths passed to these are already API-prefixed, so wrap them in
`buildPath()`. Each returns a `Vault\ResponseModels\Response`.

| Method | Purpose |
|--------|---------|
| `read(string $path)` | GET a path (cached when read cache enabled). |
| `write(string $path, array $data = [])` | Write a secret / call an endpoint with a body. |
| `list(string $path)` / `keys(string $path)` | List keys under a path. |
| `get/put/post/patch/delete/head/options(string $path, string $body = '')` | Raw verbs. |
| `revoke(string $path)` | Revoke via the SDK. |
| `send(string $method, string $path, string $body = '')` | Low-level send. |
| `authenticate(): bool`, `setAuthenticationStrategy()`, `getToken()`, `setToken()`, `setNamespace()` | Auth / token / namespace control. |
| `enableReadCache()`, `disableReadCache()`, `isReadCacheEnabled()`, `getReadCacheTtl()`, `setReadCacheTtl(int)` | Read-cache control. |

Example (KV v2 read):

```php
$response = $client->read($client->buildPath('/secret/data/my-app'));
$secret = $response->getData()['data']['value'] ?? NULL;
```

### Module-added helpers (`VaultClientInterface`)

| Method | Purpose |
|--------|---------|
| `listMounts(): ?array` | `read('/sys/mounts')` data — all secret-engine mounts. |
| `listSecretEngineMounts(array $engine_types): array` | Filter mounts by engine `type` (e.g. `['kv','aws']`). |
| `setLeaseStorage(VaultLeaseStorageInterface $s): void` | Inject a lease-storage plugin. |
| `storeLease($storage_key, $lease_id, $data, int $expires, bool $renewable): void` | Persist a lease (no-op if no storage set). |
| `retrieveLease(string $storage_key): mixed` | Fetch stored lease data. |
| `revokeLease(string $storage_key): bool` | Revoke a stored lease. |
| `renewLease(string $storage_key, int $increment): bool` | Renew one lease. |
| `renewAllLeases(int $increment): void` | Renew every stored lease (called from cron). |

`$storage_key` is a caller-chosen id such as `"key:key_machine_id"`; lease-storage plugins
HMAC-hash it before persisting (see plugins/lease-storage.md).

## Cron & cache lifecycle

- `hook_cron` (`vault_cron`): if `lease_renew_cron` is on, calls
  `$client->renewAllLeases($config->getLeaseTtlIncrement())`, then
  `VaultCacheManager::pruneCache()`.
- `hook_cache_flush` (`vault_cache_flush`): `VaultCacheManager::clearCache()`.

## Extensibility notes

`VaultClientInterface`, `VaultConfigInterface`, `VaultAuthInterface`,
`VaultLeaseStorageInterface`, and the plugin base classes are marked `@api`. `VaultConfig`
is `@internal`/`final` — customise it with a service decorator, not a subclass.
