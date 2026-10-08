<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Encrypt KMS (encrypt_kms) — agent index

Adds an **AWS KMS** encryption method to the **Encrypt** framework, delegating encrypt/decrypt to
AWS Key Management Service through **aws/aws-sdk-php**. Package `Security`. Version dir `2.x`
(installed `2.0.2`). License GPL-2.0-or-later. Core `^8.8 || ^9 || ^10 || ^11`.

- **Depends on** contrib `encrypt` (`^3.1`) and `key` (`^1.17`); composer pulls `aws/aws-sdk-php` `~3.0`.
- **No permissions of its own** (reuses Encrypt's `administer encrypt`). No Drush. Provides config schema.

## What it provides (from source)

- **EncryptionMethod plugin** `aws_kms` (`src/Plugin/EncryptionMethod/AwsKmsEncryptionMethod.php`) —
  `encrypt()`/`decrypt()` call KMS `Encrypt`/`Decrypt`. `key_type = {"aws_kms"}`.
- **KeyType** `aws_kms` (`src/Plugin/KeyType/KmsKeyType.php`) — holds a KMS key **ARN**; uses key
  input `aws_kms_arn`.
- **KeyInput** `aws_kms_arn` (`src/Plugin/KeyInput/KmsArnKeyInput.php`) — text field with ARN help.
- **KeyType** `aws_kms_data` (`src/Plugin/KeyType/KmsDataKeyType.php`) — generates an AES data key via
  KMS `GenerateDataKey` from a chosen "client master profile".
- **KeyProvider** `aws_kms` (`src/Plugin/KeyProvider/AwsKmsKeyProvider.php`) — wraps a secret with a
  KMS profile and stores the ciphertext locally as an `aws_kms_secret` config entity.
- **Config entity** `aws_kms_secret` (`src/Entity/Secret.php`) — stores id + wrapped `value`.
- **Service** `encrypt_kms.kms_client` — `Aws\Kms\KmsClient` built by `KmsClientFactory`
  (`src/KmsClientFactory.php`); logger channel `logger.channel.encrypt_kms`.
- **Route/form** `encrypt_kms.admin` at `admin/config/system/encrypt_kms`
  (`EncryptKmsConfigForm`, `_permission: administer encrypt`) → config object `encrypt_kms.settings`.
- **hook_requirements** (`encrypt_kms.install`) — checks AWS SDK presence and calls STS
  `GetCallerIdentity`.

## Solution docs

- **The AWS KMS encryption method (encrypt/decrypt, service, credentials)** →
  [plugins/encryption-method.md](plugins/encryption-method.md)
- **Key integration: KMS key type/ARN input, data-key generation, KMS key provider, Secret entity** →
  [plugins/key-integration.md](plugins/key-integration.md)
- **Settings form, config object/schema, AWS credential resolution** →
  [config/settings.md](config/settings.md)
