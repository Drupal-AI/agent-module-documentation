<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# S3 client (s3client) — agent index

**Provides an AWS `S3Client` service and a factory so other modules can use S3 with credentials from `settings.php`.**

- **Version:** 1.2.x (release 1.2.0)
- **Core:** ^10.2 || ^11 · **PHP:** 8.1 · **Library:** `aws/aws-sdk-php ~3`
- **Services:** `s3client.factory` (`S3ClientFactory`) and `s3client.s3client` (the default `Aws\S3\S3Client`).
- **API:** `getDefaultClient()` (reads `settings.php`), `createClient($key,$secret,$region,$endpoint=NULL,$bucketEndpoint=FALSE,$version='latest')`.
- **settings.php keys:** `s3client.default_key`, `.default_secret`, `.default_region`, `.default_endpoint`, `.default_bucket_endpoint` (FALSE), `.default_version` ('2006-03-01').
- **Security:** No routes/forms/permissions. Credentials read from `settings.php` via `Settings::get()` — not in config/DB, not logged. AWS SDK uses TLS with peer verification by default; no `verify => false` and no credential logging in the module. Operators should source secrets from env vars.

See [api/client.md](api/client.md).
