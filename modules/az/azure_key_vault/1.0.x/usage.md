Fetch and manage secrets and RSA keys in Azure Key Vault from Drupal via one injectable service, authenticated with an Azure AD OAuth2 client-credentials token.

---

Azure Key Vault integrates a subset of the Azure Key Vault REST API (secrets and keys) with Drupal. It depends on the `key` module and authenticates to a vault by exchanging an Azure Active Directory (AAD) service-principal client id and client secret for an OAuth2 access token (grant `client_credentials`, scope `https://vault.azure.net/.default`), then attaches that token as a `Bearer` header on each vault call. All connection details — vault base URL, AAD token URL, client id, the Key entity that holds the client secret, and the API version date/number — are set on an admin form at `/admin/config/system/az_key_vault_config` (route `azvault.admin`, permission `administer site configuration`). Site code obtains secrets/keys by calling the `azure_key_vault.http_client` service (class `AzureKeyVaultRequestHandler`) either through dependency injection of `AzureKeyVaultRequestHandlerInterface` or via `\Drupal::service('azure_key_vault.http_client')`. The optional `azure_key_vault_key_provider` submodule surfaces the same operations through the Key module UI as a KeyProvider and an 'Azure Encryption' KeyType, giving a GUI for creating and reading vault-backed keys.

---

- Retrieve a single secret value at runtime with `getSecret('my_secret')` to feed an API key or password into another integration.
- Store a new secret in the vault programmatically with `createSecret('my_secret', $value)`.
- List up to 25 secrets in the vault with `getSecrets()` for an inventory or admin overview.
- Soft-delete a recoverable secret with `deleteSecret('my_secret')`.
- Permanently purge a previously soft-deleted secret with `purgeSecret('my_secret')`.
- Generate an RSA key (2048/3072/4096-bit) inside the vault with `generateKey('mykey', 2048)`.
- Read the public modulus of a vault RSA key with `getKey('mykey')`.
- Encrypt a value with a vault RSA key (alg `RSA1_5`) using `encryptKey($plaintext, 'mykey')`.
- Decrypt a value with a vault RSA key using `decryptKey($ciphertext, 'mykey')`.
- Delete an RSA key from the vault with `deleteKey('mykey')`.
- Inject `AzureKeyVaultRequestHandlerInterface` into your own service or controller so secrets never live in Drupal config.
- Keep third-party API credentials (SMTP, payment, SaaS) out of `settings.php` and the database by fetching them from the vault on demand.
- Centralise secret storage across multiple Drupal environments (dev/stage/prod) pointing at the same or per-environment vaults.
- Rotate a credential in Azure and have Drupal pick up the new value on the next `getSecret()` call without a code deploy.
- Use the `key` submodule to let site builders create a vault-backed Authentication key through the Key UI at `/admin/config/system/keys/add`.
- Use the 'Azure Encryption' KeyType to have Key generate an RSA key directly in the vault for use by encryption modules.
- Provide a browsable key-management GUI on top of the vault for teams that prefer the Key module workflow over code.
- Store the module's own AAD client secret in a Key entity (file/env/config-override provider) rather than plaintext, per the admin form's `key_select` element.
- Point `token_url` at a specific AAD tenant endpoint (`https://login.microsoftonline.com/{TENANT_ID}/oauth2/v2.0/token`) to scope authentication to one directory.
- Pin the Key Vault REST API version via the API version date/number settings when Azure introduces breaking changes.
- Back an encryption module's key material with hardware-backed vault RSA keys instead of on-disk key files.
- Migrate secrets already committed in config into the vault, then reference them by name from code.
- Serve as the credential source for other custom modules by having them depend on and call `azure_key_vault.http_client`.
