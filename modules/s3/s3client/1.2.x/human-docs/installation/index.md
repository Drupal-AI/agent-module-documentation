# Installation

## Requirements

S3 client is lightweight but does have a couple of hard requirements:

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- **PHP 8.1 or newer**.
- The **AWS SDK for PHP**, `aws/aws-sdk-php:~3` — Composer fetches this for you
  automatically when you install the module.

There are no other Drupal module dependencies and no submodules.

## Install with Composer

From the project root:

```bash
composer require drupal/s3client -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the AWS SDK and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/s3client -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en s3client -y
```

## Configure the default connection

There is no settings form. Instead, add your default S3 connection details to
`settings.php`. Prefer environment variables over hard-coded secrets — nothing
here is exported to Drupal configuration:

```php
$settings['s3client.default_key']    = getenv('S3_CLIENT_KEY');
$settings['s3client.default_secret'] = getenv('S3_CLIENT_SECRET');
$settings['s3client.default_region'] = 'us-east-1'; // or your preferred region

// Optional — only needed for a non-AWS S3-compatible service:
$settings['s3client.default_endpoint']        = 'https://minio.example.com';
$settings['s3client.default_bucket_endpoint'] = FALSE; // TRUE if the endpoint points at the bucket
$settings['s3client.default_version']         = '2006-03-01'; // default; 'latest' also works
```

## Verify it worked

The module provides no UI to click, so the quickest check is from Drush — the
default client service should resolve without error once your credentials are in
place:

```bash
drush php:eval 'var_dump(get_class(\Drupal::service("s3client.s3client")));'
```

You should see `Aws\S3\S3Client`. From there, other modules can inject
`@s3client.s3client` or `@s3client.factory` and use the client per the AWS
documentation.
