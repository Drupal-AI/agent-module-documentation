<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Key module integration (key types, ARN input, data keys, KMS key provider)

Four Key-module plugins plus one config entity connect KMS to the Encrypt/Key stack.

## KeyType `aws_kms` — the KMS key ARN

`src/Plugin/KeyType/KmsKeyType.php` extends `KeyTypeBase`. Annotation id `aws_kms`, label "KMS Key",
`group = "encryption"`, `key_value = { "plugin" = "aws_kms_arn" }`. It carries a KMS key **ARN** as
its value; `generateKeyValue()` returns `''` and `validateKeyValue()` is a no-op. This is the key
type the `aws_kms` encryption method accepts.

## KeyInput `aws_kms_arn`

`src/Plugin/KeyInput/KmsArnKeyInput.php` extends `key`'s `TextFieldKeyInput`. Annotation id
`aws_kms_arn`. `buildConfigurationForm()` relabels the field to "KMS Key ARN" with description "The
ARN of the KMS key you wish to configure." The ARN is only an identifier — safe to store in the
Configuration key provider.

## KeyType `aws_kms_data` — generated AES data key

`src/Plugin/KeyType/KmsDataKeyType.php` extends `EncryptionKeyType`, implements
`KeyPluginFormInterface`. Annotation id `aws_kms_data`, label "KMS Data Key",
`group = "encryption"`, `key_value = { "plugin" = "generate" }`. Injects
`encrypt.encryption_profile.manager`.

- `defaultConfiguration()` adds `client_master_profile => NULL`.
- `buildConfigurationForm()` warns if the AWS SDK is missing and adds a required
  `client_master_profile` select populated from
  `profileManager->getEncryptionProfilesByEncryptionMethod("aws_kms")` — i.e. profiles that use the
  KMS encryption method above.
- `generateKeyValue(array $configuration)` (static) loads that profile and its KMS key, then calls
  the `encrypt_kms.kms_client` service:
  - key size `128` or `256` → `generateDataKey(['KeyId' => <ARN>, 'KeySpec' => 'AES_'.$size])`;
  - otherwise → `generateDataKey(['KeyId' => <ARN>, 'NumberOfBytes' => intval(key_size_other_value)/8])`.
  - Returns `$result['Plaintext']` (the raw AES data key that Real AES then uses for bulk crypto).

Config schema `key.type.aws_kms_data` (`config/schema/encrypt_kms.schema.yml`): `key_size` (int),
`client_master_profile` (string).

## KeyProvider `aws_kms` — store a KMS-wrapped secret locally

`src/Plugin/KeyProvider/AwsKmsKeyProvider.php` extends `KeyProviderBase`, implements
`KeyProviderSettableValueInterface`, `KeyPluginFormInterface`. Annotation id `aws_kms`,
`storage_method = "aws_kms"`, `key_value = { accepted = TRUE, required = TRUE }`. Injects
`entity_type.manager` (storage for `aws_kms_secret`), `encryption` (EncryptService),
`encrypt.encryption_profile.manager`.

- Config: required `client_master_profile` select (same profile list as above). Schema
  `key.provider.aws_kms`: `client_master_profile` (string).
- `setKeyValue($key, $key_value)` → `encryptionService->encrypt($key_value, <profile>)` (KMS wraps
  it) then `create()`+`save()` an `aws_kms_secret` entity with `id = $key->id()`, `value = <cipher>`.
- `getKeyValue($key)` → loads the `aws_kms_secret` by the key id and
  `encryptionService->decrypt($secret->getValue(), <profile>)`.
- `deleteKeyValue($key)` → deletes the stored secret entity, returns TRUE.

So the plaintext key material is never stored locally — only the KMS-encrypted `value` is.

## Config entity `aws_kms_secret`

`src/Entity/Secret.php` (`@ConfigEntityType id="aws_kms_secret"`, interface
`src/SecretInterface.php`). `config_export = { "id", "value" }`; `getValue()`/`setValue()` accessors.
Schema `encrypt_kms.aws_kms_secret.*` (`id`, `key_id`, `value`). Holds the KMS-wrapped secret keyed
by the Key entity's id.
