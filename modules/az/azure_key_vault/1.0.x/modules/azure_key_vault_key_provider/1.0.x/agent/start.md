<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Azure Key Vault Key Provider (azure_key_vault_key_provider) — agent index

Submodule of **azure_key_vault** that plugs the vault into the **Key** module. Package `Security`.
Depends on `key` + `azure_key_vault`. Core `^10.3 || ^11`. GPL-2.0-or-later. Version 1.0.7.
**No routes, permissions, config schema, hooks, or Drush** — just two Key plugins + a logger channel
(`azure_key_vault_key_provider.services.yml`). Both plugins are constructed with
`@azure_key_vault.http_client` and the module logger.

- **KeyProvider `azure_key_vault` + KeyType `azure_encryption`, forms, value mapping** →
  [plugins/key-provider.md](plugins/key-provider.md)

## What it provides (from source)

- **KeyProvider plugin** `AzureKeyVaultKeyProvider`
  (`src/Plugin/KeyProvider/AzureKeyVaultKeyProvider.php`), id **`azure_key_vault`**, label *"Azure Key
  Vault"*, `storage_method = "azure_key_vault"`, implements `KeyProviderSettableValueInterface` +
  `KeyPluginFormInterface`. Maps Key operations onto the parent service:
  - `authentication` / `encryption` key types → vault **Secrets** (`getSecret` / `createSecret` /
    `deleteSecret`), with an optional **Base64** toggle applied on read/write.
  - `azure_encryption` / `azure_key_import` → vault **Keys** (`getKey` / `generateKey` / `deleteKey`).
- **KeyType plugin** `AzureEncryptionKeyType` (`src/Plugin/KeyType/AzureEncryptionKeyType.php`), id
  **`azure_encryption`**, group `encryption`, `key_value.plugin = "generate"`. Generates an RSA key in the
  vault; RSA size select 2048/3072/4096 (`defaultConfiguration` = 2048).

## Access & operation

- No new access control: creating/reading/deleting these Key entities is governed entirely by the **Key**
  module (Key add form is `administer keys`). The provider only forwards to `azure_key_vault.http_client`,
  which authenticates to the vault with the parent module's AAD credentials.
- The provider form (`buildConfigurationForm`) shows a red "configure Azure Key Vault" link when
  `validateConfig()` is false, warns on unsupported key types, and (`validateConfigurationForm`) rejects
  key ids containing `_`. `AzureEncryptionKeyType::generateKeyValue()` reads the key name from
  `$_SESSION['key_name']` (set in its `validateConfigurationForm`) and calls
  `azure_key_vault.http_client->generateKey()`.
