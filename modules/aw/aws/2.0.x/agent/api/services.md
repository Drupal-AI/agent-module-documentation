<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & building a client

## `aws.client_factory` → `AwsClientFactory` (`AwsClientFactoryInterface`)

Build a configured AWS SDK client for any service:

```php
$factory = \Drupal::service('aws.client_factory');
// optional: pin a profile explicitly, else the per-service override / default profile is used
// $factory->setProfile($profile);
$s3 = $factory->getClient('s3');   // -> \Aws\S3\S3Client, or FALSE if no profile resolves
$result = $s3->listBuckets();
```

`getClient($service_id)`:
1. Looks up the service via `aws->getService($service_id)` (from `Aws\manifest()`), giving the
   SDK namespace (e.g. `S3`).
2. Chooses the profile: explicit `setProfile()` → per-service override → default profile.
3. Instantiates `\Aws\<Namespace>\<Namespace>Client` with `$profile->getClientArgs()`.

## `aws` → `Aws` (`AwsInterface`)

| Method | Returns / does |
|---|---|
| `getProfiles()` | all `aws_profile` entities |
| `getProfile($service_id)` | the profile bound to a service (override → default) |
| `getDefaultProfile()` | the profile whose `default` flag is set |
| `getServices()` | full SDK service manifest (`Aws\manifest()`) |
| `getService($service_id)` | one service's manifest entry (has `namespace`) |
| `getServiceConfig($id)` | the `{profile, version}` override for a service (or `[]`) |
| `setServiceConfig($id, $settings)` | set (`array`) or remove (`NULL`) a service override in `aws.settings` |
| `getOverrides()` | all service overrides |

## Credential resolution — `Profile::getClientArgs($version = 'latest')`

Returns `['credentials' => …, 'region' => …, 'version' => …]`. Credentials are chosen in order:

1. **Role ARN set** → `getTemporaryCredentials()` calls STS `assumeRole` and caches the temp
   credentials in the `aws_profile` key-value-expirable store (secret re-encrypted at rest).
2. **Static key + secret set** → `['key' => access_key, 'secret' => decrypted_secret]`.
3. **Neither** → `\Aws\Credentials\CredentialProvider::defaultProvider()` (environment vars, shared
   ini, EC2/ECS instance profile, etc.).

`getSecretAccessKey()` decrypts via the Encrypt module when an `encryption_profile` is set;
otherwise the stored value is returned as-is.

Note: the `plugin.manager.aws_service_manager` service is declared in `aws.services.yml` but the
services this module exposes come from the AWS SDK manifest (above), not from Drupal plugins — there
is no plugin type to implement, no Drush command, and no `hook`/`*.api.php`.
