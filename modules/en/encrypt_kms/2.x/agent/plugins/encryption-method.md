<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# EncryptionMethod plugin `aws_kms`

`src/Plugin/EncryptionMethod/AwsKmsEncryptionMethod.php` — extends `EncryptionMethodBase`
(from `encrypt`), implements `EncryptionMethodInterface`, `ContainerFactoryPluginInterface`.

Annotation:

```
@EncryptionMethod(
  id = "aws_kms",
  title = @Translation("Amazon KMS"),
  description = "Encryption using Amazon KMS",
  key_type = {"aws_kms"}
)
```

So it appears as "Amazon KMS" when building an Encryption Profile, and it only accepts a key of
type `aws_kms` (a KMS key ARN — see [key-integration.md](../key-integration.md) / the
`KmsKeyType`).

## Wiring

- `create()` injects `encrypt_kms.kms_client` (via `setKmsClient()`) and
  `logger.channel.encrypt_kms` (via `setLogger()`). The KMS client is the shared
  `Aws\Kms\KmsClient` service built by `KmsClientFactory`; see [config/settings.md](../config/settings.md).
- `checkDependencies($text, $key)` returns an error (and logs it) when `\Aws\Kms\KmsClient` is not
  autoloadable — i.e. the AWS SDK is missing.

## encrypt / decrypt

Both call KMS directly with the key ARN as `KeyId`; there is no local crypto:

- `encrypt($text, $key, $options = [])` → `kmsClient->encrypt(['KeyId' => $key, 'Plaintext' => $text])`
  and returns `$result['CiphertextBlob']`. This sends `$text` to AWS.
- `decrypt($text, $key, $options = [])` → `kmsClient->decrypt(['KeyId' => $key, 'CiphertextBlob' => $text])`
  and returns `$result['Plaintext']`.
- Both wrap the call in try/catch; on `\Exception` they log via the `encrypt_kms` error channel and
  return `FALSE`.

Because KMS `Encrypt` sends the full plaintext to AWS, this method is meant for small values (e.g.
wrapping a locally generated data key). For encrypting large content/PII, use envelope encryption:
KMS wraps an AES data key (Real AES does the bulk encryption). See
[key-integration.md](../key-integration.md).
