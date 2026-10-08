# Configure Vault (settings)

Settings form `Drupal\vault\Form\VaultConfigForm` (form id `vault.config_form`) at route
`vault.admin` → `/admin/config/system/vault`, gated by permission `administer vault`. It
edits the single config object **`vault.settings`**. On save the form also clears the Vault
client cache (`vault.cache.manager`).

## Config object `vault.settings`

| Key | Type | Install default | Runtime fallback (in `VaultConfig`) | Meaning |
|-----|------|-----------------|-------------------------------------|---------|
| `base_url` | string | `http://127.0.0.1:8200` | `https://vault:8200` | Base URL of the Vault/OpenBao server. Form field is `#type => url`, required, validated with `UrlHelper::isValid()`. |
| `plugin_auth` | string | `''` | `NULL` | Id of the selected `VaultAuth` plugin (auth strategy). No value ⇒ client cannot authenticate. |
| `auth_plugin_config` | mapping (`vault.auth_plugin.[plugin_auth]`) | — | `[]` | Per-auth-plugin settings, written by the selected auth plugin's config subform. |
| `lease_ttl_increment` | integer | `172800` (2 days) | `86400` if unset/≤0 | Seconds requested when renewing a lease; Vault may grant less. Size it to your cron interval. |
| `lease_renew_cron` | boolean | `true` | `false` unless strictly `TRUE` | Renew all stored leases during `hook_cron`. |
| `plugin_lease_storage` | string | `state` | `state` | Id of the `VaultLeaseStorage` plugin. Shipped: `state`, `static`, `encrypted_state`. |
| `lease_storage_plugin_config` | mapping (`vault.lease_storage_plugin.[plugin_lease_storage]`) | — | `[]` | Per-lease-plugin settings (e.g. `encryption_profile` for `encrypted_state`). |
| `read_cache_ttl` | integer | `0` (disabled) | `0` if unset/<0 | Seconds the client caches read results. `0` disables read caching. |

Schema: `config/schema/vault.schema.yml`. `auth_plugin_config` and `lease_storage_plugin_config`
are dynamically typed via `[%parent.plugin_auth]` / `[%parent.plugin_lease_storage]`, so each
plugin supplies its own schema (`vault.lease_storage_plugin.encrypted_state` defines
`encryption_profile: string`).

## Read via the config service

The typed getters live on `vault.config` (`Drupal\vault\VaultConfigInterface`):
`getBaseUrl()`, `getAuthPluginName()`, `getAuthPluginConfig()`, `getCronRenewEnabled()`,
`getLeasePluginName()`, `getLeasePluginConfig()`, `getLeaseTtlIncrement()`, `getReadCacheTtl()`.

## Set via Drush / PHP

```bash
drush config:set vault.settings base_url 'https://vault.example.com:8200'
drush config:set vault.settings plugin_auth token
drush config:set vault.settings lease_ttl_increment 172800
drush config:set vault.settings lease_renew_cron true
drush config:set vault.settings plugin_lease_storage encrypted_state
drush config:set vault.settings read_cache_ttl 0
```

```php
\Drupal::configFactory()->getEditable('vault.settings')
  ->set('base_url', 'https://vault.example.com:8200')
  ->set('plugin_auth', 'approle')
  ->set('read_cache_ttl', 30)
  ->save();
```

Because `auth_plugin_config` / `lease_storage_plugin_config` are keyed by the chosen plugin,
prefer the admin form (or the plugin's own API) to populate them so validation and schema apply.

## Cache

The client caches its validated auth token and, when `read_cache_ttl > 0`, key reads. The
default backing service `vault.cache` is a non-persistent `Symfony\Component\Cache\Adapter\ArrayAdapter`
(per-request). The form has a **Clear Cache** button (`cacheClearSubmitForm` →
`VaultCacheManager::clearCache()`). `hook_cache_flush` clears it on a Drupal cache rebuild;
`hook_cron` prunes expired entries.

## Runtime requirements check

`vault_requirements()` (runtime phase) reports on the status page: the `\Vault\Client` SDK
presence, whether an auth plugin is configured, and an auth **ping** — a live
`GET /v1/auth/token/lookup-self` that fails the check if the client cannot authenticate.
