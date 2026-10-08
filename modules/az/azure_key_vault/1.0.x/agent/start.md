<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure Key Vault (azure_key_vault) — agent index

Integrates a subset of the **Azure Key Vault** REST API (secrets + RSA keys) with Drupal. Authenticates
with an **Azure AD (AAD) OAuth2 client-credentials** token and calls the vault with a `Bearer` header.
Package `Security`. Depends on core-contrib **`key`**. Core `^10.3 || ^11`. License GPL-2.0-or-later.
Version 1.0.7. Configure at route **`azvault.admin`** (`/admin/config/system/az_key_vault_config`).

- **The one service and all its secret/key methods (the module's real API)** →
  [api/request-handler.md](api/request-handler.md)
- **Admin form, `azure_key_vault.settings` config object + schema, the route** →
  [config/settings.md](config/settings.md)
- **Submodule `azure_key_vault_key_provider` (Key module provider + Azure Encryption key type)** →
  [modules/azure_key_vault_key_provider/1.0.x/agent/start.md](modules/azure_key_vault_key_provider/1.0.x/agent/start.md)

## What it actually is

- **No entities, no permissions of its own, no Drush, no hooks** except `hook_help()` in
  `azure_key_vault.module`. Not a plugin-type provider (the submodule's plugins are Key module's types).
- **Two services** (`azure_key_vault.services.yml`):
  - `azure_key_vault.configuration` = `AzureKeyVaultConfigurationService` — reads the six settings from
    `azure_key_vault.settings`; resolves the client secret through `@key.repository` (`getClientSecret()`).
  - `azure_key_vault.http_client` = `AzureKeyVaultRequestHandler` (implements
    `AzureKeyVaultRequestHandlerInterface`) — the public API. Built with `@http_client` (Guzzle),
    `@cache.default`, and the module's logger channel.
- **One route** `azvault.admin` → `Form\AzVaultConfigForm`, permission `administer site configuration`
  (`_admin_route: TRUE`). Menu link `azvault.admin` under *Configuration → System*.

## How it authenticates (from source)

- `AzureKeyVaultRequestHandler::getAccessToken()` (called from the constructor) POSTs `form_params`
  `client_id` / `client_secret` / `scope=https://vault.azure.net/.default` / `grant_type=client_credentials`
  to `token_url` and keeps `$data['access_token']`. Client id comes from config `vault_id`; client secret
  comes from the **Key entity** named by config `vault_secret` (`ConfigurationService::getClientSecret()`
  → `keyService->getKey($id)->getKeyValue()`).
- Every vault call is built in `sendRequest($type, $resource_name, $http_request, $request_body)`:
  `getUrl()` (config `azure_url`) + a per-type path (`secrets/…`, `keys/…`, `deletedsecrets/…`) +
  `?api-version=<api_version_number>`, with headers `Authorization: Bearer <token>`,
  `Accept`/`Content-Type: application/json` and `json => $request_body`. Non-200 logs an error and returns
  a decoded `{"value":"…error"}`.

## Public methods (see api/request-handler.md)

Secrets: `createSecret`, `getSecret`, `getSecrets`, `deleteSecret`, `purgeSecret`. Keys: `generateKey`,
`getKey`, `encryptKey`, `decryptKey`, `deleteKey`. Plus `getData($full_url)` (generic GET) and
`validateConfig()` (true when a token was obtained). Usage snippet:
`\Drupal::service('azure_key_vault.http_client')->getSecret("your_secret_name")`.

## Config (see config/settings.md)

Config object `azure_key_vault.settings`: `azure_url`, `token_url`, `vault_id`, `vault_secret` (Key id),
`api_version_date`, `api_version_number`. Schema in `config/schema/azure_key_vault.schema.yml`. Install
defaults in `config/install/`, which also ships a placeholder `key.key.vault_secret` Key entity.
