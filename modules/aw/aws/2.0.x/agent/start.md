<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Amazon Web Services (aws) — agent index

Stores AWS credentials/regions as **profile** config entities and hands other modules a
configured **AWS SDK for PHP** client. Requires the `aws/aws-sdk-php` library. Makes no AWS
calls itself. No `configure` route key (admin UI at `/admin/config/services/aws`).

- **Profiles, credentials, regions, service overrides, routes, permission** →
  [configure/profiles.md](configure/profiles.md)
- **`aws` and `aws.client_factory` services, `getClient()`, credential resolution** →
  [api/services.md](api/services.md)

Key facts:
- Profile = config entity type **`aws_profile`** (`aws.profile.<id>`). Fields: `id`, `name`,
  `default`, `region`, `aws_access_key_id`, `aws_secret_access_key`, `aws_role_arn`,
  `aws_role_session_name`, `encryption_profile`.
- Service overrides in config **`aws.settings:services.<service_id>`** = `{profile, version}`.
  Service list comes from the SDK's `Aws\manifest()` (s3, ec2, sqs, …).
- Client: `\Drupal::service('aws.client_factory')->getClient('s3')` →
  `\Aws\S3\S3Client`. Profile resolution: explicit `setProfile()` → per-service override → default.
- Credential order in `Profile::getClientArgs()`: role ARN (STS temp creds, cached) → stored
  key/secret → SDK `CredentialProvider::defaultProvider()` (env/instance profile).
- Permission `administer aws`. Optional `drupal/encrypt` to encrypt the stored secret.
