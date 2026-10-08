<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EncryptionMethod plugin: vault_transit

File: `src/Plugin/EncryptionMethod/VaultTransitEncryptionMethod.php`
Class: `VaultTransitEncryptionMethod extends EncryptionMethodBase implements EncryptionMethodInterface, ContainerFactoryPluginInterface`.

Annotation:
```
@EncryptionMethod(
  id = "vault_transit",
  title = @Translation("Vault Transit"),
  description = "Encryption using Vault Transit secret backend",
  key_type = {"vault_transit"}
)
```
`key_type = {"vault_transit"}` ties it to this module's KeyType (see
[key-integration.md](key-integration.md)); the Encrypt profile's key value is the **name** of a Vault
transit key.

## Dependencies injected (`create()`)

- `vault.vault_client_no_lease_storage` → `\Drupal\vault\VaultClientInterface $vaultClient` (the Vault
  module's HTTP client; address/TLS/token live in the **Vault** module, not here).
- `logger.channel.vault` → `\Psr\Log\LoggerInterface $logger` (logs to the **vault** channel).
- `string_translation`.

Note: the class declares `protected ImmutableConfig $settings;` but never assigns or reads it — this
module has no config object.

## encrypt($text, $key)

1. Builds `['name' => $key, 'plaintext' => base64_encode($text)]`.
2. `$response = $this->vaultClient->write(sprintf("/transit/encrypt/%s", $key), $data);`
3. Returns `$response->getData()['ciphertext']` when present.
4. If no `ciphertext`, throws `EncryptException('no response when encrypting data')`.
5. Any `\Exception` → `logException($e, $text)` then `throw new EncryptException('unable to encrypt data')`.

Return value is Vault's ciphertext string (e.g. `vault:v1:...`), which Encrypt stores.

## decrypt($text, $key): string

1. Builds `['name' => $key, 'ciphertext' => $text]`.
2. `$this->vaultClient->write(sprintf("/transit/decrypt/%s", $key), $data);`
3. If `!empty($data['plaintext'])` returns `base64_decode($data['plaintext'])`.
4. Otherwise / on any `\Exception` → `logException($e, $text)` then
   `throw new EncryptException('unexpected response when decrypting ' . $key)`.

## checkDependencies($text = NULL, $key = NULL): array

Returns an error (and logs it) only if `\Drupal\vault\VaultClient` class is missing:
*"HashiCorp Vault library is not correctly installed."* Encrypt calls this before using the method.

## logException(\Exception $e, string $text): void

Logs the failure to the `vault` logger channel, redacting the payload from the exception message
before it is recorded. Called from both encrypt and decrypt on any error path.

## Operating notes

- All key material and the actual Transit HTTP request are handled by the Vault module's client; this
  plugin only shapes the request body and reads `ciphertext`/`plaintext` from the response.
- Encrypt/decrypt only work while the site can reach and authenticate to Vault — configure that in the
  Vault module first (Vault address + token via Key), then create an Encryption Profile using this
  method.
