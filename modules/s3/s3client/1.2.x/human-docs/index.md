# S3 client — manual setup guide

**S3 client** (`s3client`) is a small developer building block. It wraps the
official AWS SDK for PHP and hands other modules a ready-to-use
`Aws\S3\S3Client` service plus a factory, so code that needs to talk to Amazon S3
(or any S3-compatible object store such as MinIO, Ceph or DigitalOcean Spaces)
does not have to wire up credentials and clients itself.

It is deliberately narrow. It does **not** integrate with Drupal's file system,
it does **not** register an `s3://` stream wrapper, and it has **no admin UI or
settings form** — if you want S3 to back your site's uploads, that is the job of
the S3 File System (`s3fs`) module, not this one. S3 client is only for
developers who want to inject an S3 client into their own services and then put,
list, get and delete objects directly, following the AWS documentation.

The one thing you configure lives in `settings.php`, not in the admin interface:
a set of `$settings['s3client.default_*']` keys that describe a default
connection. There is nothing to configure through the browser and nothing is
stored in Drupal's configuration or database. The module needs PHP 8.1+ and pulls
in `aws/aws-sdk-php ~3` automatically via Composer. It has no submodules and no
dependencies on other Drupal modules.

On security: credentials are read only from `settings.php` (ideally sourced from
environment variables), never written to configuration, the database, or any log.
The client the module builds uses the AWS SDK's normal HTTPS/TLS with peer
verification — the module sets no `verify => false` override and does not log your
secrets.

This guide is written for a **human**. If you are an AI coding agent, read the
sibling [`agent/`](../agent/start.md) docs instead — they are terser and
token-cheap.

## Contents

1. [Installation](installation/index.md) — install with Composer and declare your
   default S3 connection in `settings.php`.

## How to use it

Because this is a developer tool, there is no page to visit. Two services are
available to inject into your own code:

- `s3client.s3client` — the default `Aws\S3\S3Client`, preconfigured from your
  `settings.php` keys.
- `s3client.factory` — a factory whose `getDefaultClient()` returns that same
  default client, and whose `createClient($key, $secret, $region, …)` builds an
  ad-hoc client for a second bucket or account.

Configure the default connection by adding keys to `settings.php`:

```php
$settings['s3client.default_key']    = getenv('S3_CLIENT_KEY');
$settings['s3client.default_secret'] = getenv('S3_CLIENT_SECRET');
$settings['s3client.default_region'] = 'us-east-1';
// Optional, only for non-AWS S3-compatible services:
$settings['s3client.default_endpoint']        = 'https://s3.example.com';
$settings['s3client.default_bucket_endpoint'] = TRUE;  // endpoint points straight at the bucket
$settings['s3client.default_version']         = 'latest';
```

Then, for example in your module's `services.yml`, pass `@s3client.s3client` or
`@s3client.factory` as an argument to your own service and interact with the
client directly. See [Installation](installation/index.md) for the full setup.

One small note carried over from the module's own docs: the
`S3ClientFactoryInterface::createClient()` signature declares only
`$key, $secret, $region`, while the implementing class also accepts the optional
`$endpoint`, `$bucketEndpoint` and `$version` arguments shown above.
