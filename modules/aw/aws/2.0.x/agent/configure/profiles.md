<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Profiles & service overrides

Admin UI: *Configuration › Web Services › Amazon Web Services*, `/admin/config/services/aws`
(route `aws.overview`), permission **`administer aws`**. There is no `configure` route key in
info.yml; the overview page is the entry point.

## AWS Profile (config entity `aws_profile`)

Config name `aws.profile.<id>` (config_prefix `profile`, entity type id `aws_profile`). Fields:

| Field | Meaning |
|---|---|
| `id` / `name` | machine id / label |
| `default` | integer flag; the default profile used when a service has no override |
| `region` | AWS region (e.g. `us-east-1`) |
| `aws_access_key_id` | static access key id (optional) |
| `aws_secret_access_key` | secret key; **encrypted** if `encryption_profile` set, else stored plaintext in config |
| `aws_role_arn` | IAM role ARN to assume via STS (optional; if set, temporary creds are used) |
| `aws_role_session_name` | session name for the assumed-role credentials |
| `encryption_profile` | an Encrypt module `encryption_profile` id, or `_none` |

Profile entity routes (from the entity route provider): collection
`/admin/config/services/aws/profiles`, add `/admin/config/services/aws/add-profile`, edit/delete
under `/admin/config/services/aws/profile/{aws_profile}`.

### Create a profile in code

```php
$storage = \Drupal::entityTypeManager()->getStorage('aws_profile');
$profile = $storage->create([
  'id' => 'prod',
  'name' => 'Production',
  'default' => 1,
  'region' => 'us-east-1',
  'aws_access_key_id' => 'AKIA...',
  // Prefer setSecretAccessKey() (encrypts if an encryption_profile is set):
  'encryption_profile' => '_none',
]);
$profile->setSecretAccessKey('...');   // or leave keys empty to use a role/default provider
$profile->save();
```

Read back: `drush cget aws.profile.prod`. Mark default via `setDefault(TRUE)`.

## Service overrides (config `aws.settings`)

The AWS **service** list is the SDK's `Aws\manifest()` (s3, ec2, sqs, sns, ses, dynamodb, …) — not
Drupal plugins. Per service you can pin a profile and API version:

```yaml
# aws.settings
services:
  s3:
    profile: prod
    version: latest
```

Manage via the UI (routes `aws.service.add` / `aws.service.edit` / `aws.service.delete` under
`/admin/config/services/aws/service/...`) or the `aws` service:

```php
$aws = \Drupal::service('aws');
$aws->setServiceConfig('s3', ['profile' => 'prod', 'version' => 'latest']); // set
$aws->setServiceConfig('s3', NULL);                                          // remove override
$aws->getServiceConfig('s3');                                                // read
```

`getProfile($service_id)` returns the service's override profile, falling back to the default
profile. See [api/services.md](../api/services.md) for building a client.
