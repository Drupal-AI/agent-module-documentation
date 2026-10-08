<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key plugins — provider `azure_key_vault` + type `azure_encryption`

Two Key module plugins, both injected with `@azure_key_vault.http_client`
(`AzureKeyVaultRequestHandlerInterface`) and `@logger.channel.azure_key_vault_key_provider`
(`azure_key_vault_key_provider.services.yml`).

## KeyProvider `AzureKeyVaultKeyProvider`

File `src/Plugin/KeyProvider/AzureKeyVaultKeyProvider.php`. Annotation: id `azure_key_vault`, label
"Azure Key Vault", `storage_method = "azure_key_vault"`, `key_value = { accepted, required }`. Extends
`KeyProviderBase`, implements `KeyProviderSettableValueInterface` + `KeyPluginFormInterface`.

**Value mapping by key type** (branch on `$key->getKeyType()->pluginId`):

| Key type | `getKeyValue()` | `setKeyValue()` | `deleteKeyValue()` |
|---|---|---|---|
| `authentication`, `encryption` | `azkvHandler->getSecret($key->id())` | `createSecret($key->id(), $value)` | `deleteSecret($key->id())` |
| `azure_encryption`, `azure_key_import` | `getKey($key->id())` (getKeyValue); note read uses these two | — (`azure_key_import` returns FALSE / TODO importKey) | `deleteKey($key->id())` |

- The Key entity **id** is used as the vault secret/key name.
- **Base64 toggle:** `buildConfigurationForm()` adds a `base64_encoded` checkbox only when the key type's
  group is `encryption`. `getKeyValue()` `base64_decode`s and `setKeyValue()` `base64_encode`s when the
  stored config `base64_encoded` is truthy.
- All three value methods wrap the handler call in try/catch and, on `\Exception`, call `logException()`
  (logs code + message to the module channel) and return `FALSE`.
- `generateKey()` (protected) is called for `azure_encryption` types: reads `key_size` from the key
  type's config and calls `azkvHandler->generateKey($key->id(), $key_size)`.

**Form / validation:**
- `buildConfigurationForm()`: if `validateConfig()` is false, prints a red markup link to
  `azvault.admin` ("configure"). If the selected key type is not authentication/encryption/azure_encryption
  it prints a red warning; for `encryption` it prints an orange "stored under Secrets" note.
- `validateConfigurationForm()`: sets a form error on `key_provider` when `validateConfig()` is false;
  and a `label` error when the key id contains `_` ("keep the machine name without `_`").
- `submitConfigurationForm()`: stores `['base64_encoded' => …]` into plugin config.

## KeyType `AzureEncryptionKeyType`

File `src/Plugin/KeyType/AzureEncryptionKeyType.php`. Annotation: id `azure_encryption`, label
"Azure Encryption", group `encryption`, `key_value = { plugin = "generate" }`. Extends `KeyTypeBase`,
implements `KeyPluginFormInterface`.

- `defaultConfiguration()` = `['key_size' => 2048]`. `buildConfigurationForm()` renders a required
  `key_size` select (2048/3072/4096) and a red warning when the chosen key provider is not
  `azure_key_vault`.
- `validateConfigurationForm()` stashes the entity id in `$_SESSION['key_name']` (comment: config isn't
  accessible later). `submitConfigurationForm()` saves the form values into plugin config.
- **`generateKeyValue($configuration)` (static):** reads `key_size` from config + `key_name` from
  `$_SESSION['key_name']`, then `\Drupal::service('azure_key_vault.http_client')->generateKey($key_name,
  (int) $key_size)` — i.e. creates the RSA key in the vault and returns its public modulus.
- `validateKeyValue()` contains a commented-out size check ("doesn't work well with Azure RSA keys,
  disabled") — effectively a no-op.

## Operating it

1. Enable the submodule; ensure `azure_key_vault` is configured (a working vault + client secret Key).
2. `/admin/config/system/keys/add`: pick key type Authentication/Encryption (→ vault Secret) or Azure
   Encryption (→ generated vault RSA Key), and key provider **Azure Key Vault**.
3. Give the key a machine name **without `_`**. Consuming code uses the Key entity normally
   (`$key->getKeyValue()`), which fetches from the vault on each read (no local caching).
