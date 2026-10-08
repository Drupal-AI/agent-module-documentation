Exposes Azure Key Vault through the Key module as a key provider plus an "Azure Encryption" key type, so vault-backed secrets and RSA keys can be created and read from the Key UI instead of in code.

---

The `azure_key_vault_key_provider` submodule connects the parent module's `azure_key_vault.http_client` service to the Key module. It registers a **KeyProvider** plugin (id `azure_key_vault`, "Azure Key Vault") that reads/writes key values through the vault: Authentication and Encryption keys are stored as vault **Secrets** (`createSecret`/`getSecret`/`deleteSecret`), while the module's own **Azure Encryption** key type maps to vault **Keys** (`generateKey`/`getKey`/`deleteKey`). It also registers a **KeyType** plugin (id `azure_encryption`, group `encryption`) that generates an RSA key (2048/3072/4096-bit) directly in the vault when a Key is created. The provider's config form offers a Base64-encoding toggle for encryption keys and blocks unsupported key types; it warns and errors when the parent module has no working vault configuration. Depends on `key` and `azure_key_vault`. It provides no routes, permissions, config schema or services of its own beyond the two plugins and a logger channel — all access control is the Key module's.

---

- Create a vault-backed **Authentication** key from `/admin/config/system/keys/add` and have its value stored as an Azure Key Vault Secret.
- Read a Key's value in code (`$key->getKeyValue()`) and have it fetched live from the vault via the provider.
- Store an **Encryption** key's raw material as a vault Secret through the Key UI.
- Toggle **Base64-encoded** storage for encryption keys so binary key material round-trips safely.
- Use the **Azure Encryption** key type to generate a fresh RSA key inside the vault instead of on disk.
- Choose an RSA key size of 2048, 3072 or 4096 bits when generating an Azure Encryption key.
- Delete a Key in Drupal and have the provider soft-delete the matching vault Secret or delete the vault Key.
- Give site builders a GUI for vault key management without granting them code access.
- Back a field-encryption or encrypt module with an RSA key that never leaves Azure Key Vault.
- Get an inline "configure Azure Key Vault" prompt on the Key form when the vault connection is missing.
- Enforce vault-friendly key machine names (the provider rejects `_` in the id) at Key creation time.
- Centralise both secrets and encryption keys for a site in one Azure vault, managed through Key.
- Migrate an existing file/config Key to Azure Key Vault by re-creating it with this provider.
- Combine with modules that consume Key entities (encrypt, real_aes, mailer credentials, etc.) so their key source is the vault.
- Audit vault key operations through the `azure_key_vault_key_provider` logger channel.
