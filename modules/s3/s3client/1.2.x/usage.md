<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
S3 client is a small developer building block that wraps the AWS SDK for PHP and exposes a preconfigured `Aws\S3\S3Client` service plus a factory so other modules can talk to Amazon S3 (or S3-compatible object stores) without wiring credentials themselves.
---
The `s3client.factory` service (`S3ClientFactory`) has two methods. `getDefaultClient()` reads connection details from `settings.php` via `Settings::get()` — `s3client.default_key`, `s3client.default_secret`, `s3client.default_region`, optional `s3client.default_endpoint`, `s3client.default_bucket_endpoint` (default FALSE) and `s3client.default_version` (default `2006-03-01`) — and returns a client; `createClient($key, $secret, $region, $endpoint, $bucketEndpoint, $version)` builds an ad-hoc client for any credentials/region. The container also registers `s3client.s3client`, the default client itself, for direct injection.

Security posture is reasonable: credentials come from `settings.php` (not stored in config/DB and not written to any log), and the module builds a standard `Aws\Credentials\Credentials` object handed to the AWS SDK, which uses HTTPS/TLS with peer verification by default — there is no `verify => false` or TLS override and no credential logging in this code. Operators still control credential handling by choosing what to put in `settings.php` (ideally sourced from environment variables). PHP 8.1+ and `aws/aws-sdk-php ~3` are required. Note: the `S3ClientFactoryInterface::createClient()` signature omits the optional endpoint/version params that the class implements.
---
- Inject a ready-to-use `Aws\S3\S3Client` via the `s3client.s3client` service.
- Get the default S3 client in code from `s3client.factory`.
- Configure default S3 credentials/region in `settings.php`.
- Point the client at an S3-compatible endpoint (MinIO, Ceph, DigitalOcean Spaces).
- Toggle path- vs bucket-style addressing with `s3client.default_bucket_endpoint`.
- Pin the S3 API version via `s3client.default_version`.
- Create an ad-hoc client for a second bucket/account with `createClient()`.
- Upload objects to S3 from a custom module using the injected client.
- Download / stream objects from S3.
- Generate presigned URLs for S3 objects.
- List bucket contents programmatically.
- Delete or copy S3 objects.
- Source credentials from environment variables referenced in `settings.php`.
- Share one AWS SDK configuration across multiple modules.
- Back a custom stream wrapper or file storage with S3.
- Integrate S3 uploads into queue/batch jobs.
- Keep AWS secrets out of exported configuration.
