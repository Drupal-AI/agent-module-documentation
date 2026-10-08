<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Encrypt KMS adds an "Amazon KMS" encryption method (plus matching Key module key type, key input, and key provider plugins) to the Encrypt framework, delegating encrypt/decrypt operations to AWS Key Management Service through the AWS SDK for PHP.

---

Encrypt KMS extends the Encrypt and Key modules so a Drupal site can use AWS KMS as its encryption backend. It ships an `EncryptionMethod` plugin (`aws_kms`) whose `encrypt()`/`decrypt()` call the KMS `Encrypt`/`Decrypt` API, a `KeyType` (`aws_kms`) that holds a KMS key ARN entered through a dedicated `KeyInput` (`aws_kms_arn`), a `KeyType` (`aws_kms_data`) that generates an AES data key via KMS `GenerateDataKey`, and a `KeyProvider` (`aws_kms`) that stores a KMS-wrapped secret locally as an `aws_kms_secret` config entity. The AWS KMS client is built by `KmsClientFactory` and shared as the `encrypt_kms.kms_client` service; it reads region and (optional) access key/secret from the `encrypt_kms.settings` config object edited at `admin/config/system/encrypt_kms` (`administer encrypt` permission). If no key/secret is set in config, the AWS SDK's default credential chain applies (IAM instance profile, environment variables, `~/.aws/credentials`). The recommended pattern for sensitive data is envelope encryption: use a KMS-backed profile to wrap a locally generated AES data key (with Real AES) so only the wrapped key, never plaintext content, is sent to AWS.

---

- Encrypt Drupal field data using AWS KMS-managed keys.
- Add "Amazon KMS" as a selectable encryption method on an Encryption Profile.
- Register a KMS key by its ARN as a Key entity (KMS Key type).
- Enter a KMS key ARN through the ARN-specific key input field.
- Configure the AWS region that contains your KMS key(s).
- Provide AWS access key and secret through the module's settings form.
- Supply AWS credentials via `settings.php` config overrides instead of the form.
- Rely on an IAM instance profile so no static credentials live in Drupal.
- Fall back to environment-variable AWS credentials via the SDK default chain.
- Fall back to a `~/.aws/credentials` profile via the SDK default chain.
- Generate an AES data key from a KMS customer master key (GenerateDataKey).
- Build an envelope-encryption setup with Real AES for PII/PHI data.
- Keep plaintext content on-site while sending only wrapped keys to AWS.
- Choose a 128- or 256-bit AES data key, or a custom byte length.
- Store an arbitrary secret in KMS using the AWS KMS key provider.
- Encrypt Webform submission values via a KMS encryption profile.
- Encrypt entity/field values through the Field Encryption ecosystem.
- Verify AWS SDK availability and credentials via the module's status report.
- Confirm the caller identity (STS GetCallerIdentity) at the Status report page.
- Centralize key management in AWS rather than on the Drupal server.
- Rotate or restrict access by managing the KMS key policy in AWS.
- Restrict who can administer the integration with the `administer encrypt` permission.
- Reuse an existing Encryption Profile as a "client master profile" for data keys.
- Migrate an on-server encryption key to a KMS-managed workflow.
