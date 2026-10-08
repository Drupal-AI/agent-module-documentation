<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Amazon Web Services provides a unified way to store AWS credentials/regions as reusable "profiles" and hand other Drupal modules a ready-configured AWS SDK for PHP client for any AWS service.

---

The module is credential/client plumbing for the `aws/aws-sdk-php` library — it makes no AWS calls of its own. You define one or more **AWS Profile** config entities (entity type `aws_profile`, config `aws.profile.<id>`) holding a `region`, either static credentials (`aws_access_key_id` + `aws_secret_access_key`) or an IAM **role ARN** (`aws_role_arn` + `aws_role_session_name`) to assume via STS, an optional Encrypt `encryption_profile` to protect the secret at rest, and a `default` flag. Managed under *Configuration › Web Services › Amazon Web Services* (`/admin/config/services/aws`, permission `administer aws`). The list of AWS **services** (S3, EC2, SQS, …) comes straight from the SDK's own `Aws\manifest()`; per service you can save an **override** in config `aws.settings:services.<service_id>` = `{profile, version}` to pin which profile and API version that service uses. Code obtains a client through the `aws.client_factory` service: `getClient($service_id)` resolves the profile (explicit → per-service override → default), builds SDK client args from the profile (`getClientArgs()`), and instantiates `\Aws\<Namespace>\<Namespace>Client`. Credential resolution inside `getClientArgs()` is: if a role ARN is set, fetch temporary STS credentials (cached in a key-value-expirable store); else use the stored access key/secret; else fall back to the SDK's `CredentialProvider::defaultProvider()` (environment, EC2 instance profile, etc.). The `aws` service exposes profile/service helpers (`getProfiles`, `getProfile`, `getDefaultProfile`, `getServices`, `getService`, `getServiceConfig`, `setServiceConfig`, `getOverrides`).

---

- Centralize AWS credentials once and reuse them across every AWS-consuming module.
- Store an access key + secret + region as a named profile for S3 uploads.
- Use an IAM role ARN so the site assumes a role via STS instead of long-lived keys.
- Fall back to the EC2 instance profile / environment credentials by leaving keys blank.
- Encrypt the stored secret access key at rest via an Encrypt encryption profile.
- Mark one profile as the default so services with no override use it.
- Override which profile a specific AWS service (e.g. S3) uses.
- Pin an AWS API version per service via a service override.
- Get a ready-to-use `S3Client` in custom code with `aws.client_factory->getClient('s3')`.
- Provide different profiles per environment (dev keys vs prod role) via config.
- Assume a cross-account role for a specific integration using a role ARN profile.
- Give a background/queue worker AWS credentials through a shared profile.
- Build a client for SQS, SNS, SES, DynamoDB, or any SDK service by service id.
- Rotate credentials in one place (the profile) without touching consumer modules.
- Set the AWS region per profile to keep data in-region.
- Export AWS profiles and service overrides as Drupal config for deployment.
- Let a contrib module (e.g. an S3 filesystem) reuse the site's AWS profile.
- Keep temporary STS credentials cached and auto-refreshed via the expirable key-value store.
- Separate a read-only profile from a read-write profile for least privilege.
- Manage a named session for assumed-role credentials (`aws_role_session_name`).
- Audit which profile each AWS service is bound to via the overrides config.
- Avoid hardcoding AWS keys in settings.php by using managed profile entities.
- Supply credentials to the AWS SDK for PHP without writing client bootstrapping code.
- Switch a service from static keys to a role by editing its profile.
