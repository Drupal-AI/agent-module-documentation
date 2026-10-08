<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# S3 client — configuration & use

## settings.php (default client)
```php
$settings['s3client.default_key'] = getenv('AWS_ACCESS_KEY_ID');
$settings['s3client.default_secret'] = getenv('AWS_SECRET_ACCESS_KEY');
$settings['s3client.default_region'] = 'eu-west-1';
// Optional (for S3-compatible stores):
$settings['s3client.default_endpoint'] = 'https://minio.example.com';
$settings['s3client.default_bucket_endpoint'] = FALSE;
$settings['s3client.default_version'] = '2006-03-01';
```
Prefer environment variables over hard-coded secrets; nothing here is exported to config.

## Getting a client
```php
// Inject the default client service:
$s3 = \Drupal::service('s3client.s3client');           // Aws\S3\S3Client
// Or the factory for ad-hoc credentials:
$factory = \Drupal::service('s3client.factory');
$s3 = $factory->getDefaultClient();
$other = $factory->createClient($key, $secret, 'us-east-1', $endpoint, FALSE, 'latest');
```

## Notes
- `S3ClientFactory` wraps the AWS SDK (`aws/aws-sdk-php ~3`); TLS peer verification is the SDK default — the module sets no `verify => false`.
- Credentials are passed as `Aws\Credentials\Credentials` and never logged by this module.
- Interface `createClient()` declares only `$key,$secret,$region`; the implementation adds optional `$endpoint,$bucketEndpoint,$version`.
