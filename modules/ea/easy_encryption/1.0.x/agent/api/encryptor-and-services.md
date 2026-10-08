<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Public API: Encryptor + key-management services

All services are autowired; inject by interface. Most consumers only need the Key module
(`getKeyValue()`); these are for programmatic encryption and key lifecycle.

## Encryption

`Drupal\easy_encryption\Encryption\EncryptorInterface` (default impl `SodiumSealedBoxEncryptor`):

```php
$enc = \Drupal::service(\Drupal\easy_encryption\Encryption\EncryptorInterface::class);
$value = $enc->encrypt('secret');          // -> EncryptedValue (ciphertext + key id metadata)
$plain = $enc->decrypt($value);            // -> string (needs private key)
$enc->selfTest();                          // throws EncryptionException on failure
```

- `EncryptedValue` and `EncryptionKeyId` are immutable value objects; private keys are zeroed with
  `sodium_memzero()` after use.

## Key lifecycle services (inject by interface)

- `KeyManagement\KeyGeneratorInterface::generate(): EncryptionKeyId` — create a new key pair.
- `KeyManagement\KeyActivatorInterface::activate(EncryptionKeyId)` — make a key pair active
  (notifies tagged activation observers).
- `KeyManagement\KeyRotatorInterface` — `plan(bool $includeReencryptCounts): KeyRotationPlan` and
  `rotate(KeyRotationOptions): KeyRotationResult` (options: `reencryptKeys`, `failOnReencryptErrors`).
- `KeyManagement\KeyPrunerInterface::pruneUnused(): KeyPruneResult` — delete unused key pairs
  (notifies deletion observers).
- `KeyManagement\KeyUsageTrackerInterface::getKeyUsageMapping()` — which Key entities reference which
  encryption key (aggregates tagged `easy_encryption.key_usage_provider`s).
- `KeyManagement\Port\KeyRegistryInterface` — `getActiveKeyId()`, `listKnownKeyIds()` (read);
  `MutableKeyRegistryInterface` to mutate. Backed by `easy_encryption.keys` config.

## Key transfer

`KeyTransfer\KeyTransferInterface`:

```php
$pkg = $svc->exportKey($keyId);                 // portable package string
['key_id' => $id, 'activated' => $b] = $svc->importKey($pkg, $activate = FALSE);
```

Exposed as a UI in the `easy_encryption_admin` submodule.

## Plugins provided

- Key provider `easy_encrypted` (`Plugin/KeyProvider/EasyEncryptedKeyProvider`) — stores encrypted
  values; also decorates the core `file` provider (`SitePrivateKeyFileKeyProviderDecorator`) for
  private-key storage.
- Config action `ensureEasyEncryptionSetup` (`Plugin/ConfigAction/EnsureEasyEncryptionSetup`) —
  idempotently generate+activate a key pair (for recipes; recipes skip `hook_install`).
