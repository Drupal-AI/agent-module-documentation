<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extension points

The module is built around ports/adapters, so several parts are swappable or extensible via tagged
services (defined in `easy_encryption.services.yml`).

## Swap the cryptography backend

`EncryptorInterface` is bound to `SodiumSealedBoxEncryptor`. Override the service to change the
backend (the public API is key/key-id oriented, not sodium-specific):

```yaml
# your_module.services.yml
services:
  Drupal\easy_encryption\Encryption\EncryptorInterface:
    class: Drupal\your_module\MyEncryptor
```

## Tagged service collectors

- `easy_encryption.key_activation_observer` — notified when a key pair is activated
  (`KeyActivator`). Implement `KeyManagement\Observers\KeyActivatedObserverInterface`.
- `easy_encryption.key_deletion_observer` — notified when a key pair is pruned/deleted
  (`KeyPruner`). Implement `KeyManagement\Observers\KeyDeletedObserverInterface`.
- `easy_encryption.key_usage_provider` — contributes to the key-usage map (which Key entities use
  which encryption key). Implement `KeyManagement\Port\KeyUsageProviderInterface`. The built-in
  adapter maps `easy_encrypted` Key entities.
- `easy_encryption.key_transfer_payload_handler` — handles a payload type during key export/import
  (`KeyTransfer`). Implement `KeyTransfer\Port\KeyTransferPayloadHandlerInterface`. The built-in
  handler moves sodium key pairs.

Tag your service and implement the matching interface:

```yaml
services:
  Drupal\your_module\MyActivationObserver:
    tags:
      - { name: easy_encryption.key_activation_observer }
```

## Ports you can re-bind

`KeyRegistryInterface` / `MutableKeyRegistryInterface` (default `ConfigKeyRegistry`, backed by
`easy_encryption.keys`), `SodiumKeyPairReadRepositoryInterface` / `…WriteRepositoryInterface`
(default `SodiumKeyPairRepositoryUsingKeyEntities`), and `KeyPackageCodecInterface` are all bound to
default adapters you can override in your own `services.yml`.

## Recipe integration

Use the `ensureEasyEncryptionSetup` config action in a recipe to guarantee an active key pair exists
(idempotent) without relying on `hook_install` (which recipes don't run).
