# Installation

## Requirements

Flysystem Aliyun OSS needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Flysystem** module (`flysystem`) enabled — this is the required
  dependency that provides the stream-wrapper framework.
- The **`aliyuncs/oss-sdk-php`** PHP library (`^2.4.0`), the official Alibaba
  Cloud OSS SDK. Composer pulls this in automatically.
- An **Aliyun OSS bucket** and a set of RAM access credentials (an access key ID
  and secret) with permission to read and write objects in that bucket.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem_aliyun_oss -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Aliyun OSS
SDK and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flysystem_aliyun_oss -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem_aliyun_oss -y
```

Enabling the module registers the `aliyun_oss` driver with Flysystem, but nothing
is stored on OSS yet — you must define a scheme in `settings.php` first.

## Configure the scheme in settings.php

This module has no admin form; the storage scheme lives in `settings.php`. See
"How to use it" in the [guide overview](../index.md) for a complete example. The
short version is: add an `oss` entry to `$settings['flysystem']` with your
bucket, endpoint, and credentials, then optionally set
`$config['system.file']['default_scheme'] = 'oss';`.

### Keep your credentials out of version control

Your OSS access key ID and secret are **secrets**. Do not paste them literally
into `settings.php` if that file is committed. Instead:

- Store them in environment variables (for DDEV:
  `ddev dotenv set .ddev/.env --aliyun-oss-key-id=<value>` and
  `--aliyun-oss-key-secret=<value>`, then `ddev restart`).
- Read them in `settings.php` with `getenv('ALIYUN_OSS_KEY_ID')` and
  `getenv('ALIYUN_OSS_KEY_SECRET')`.
- Never commit `.ddev/.env` or any file holding the raw secret.

Also remember to set **`use_https` to `TRUE`** in the scheme config — it defaults
to `FALSE`, so TLS is not on unless you enable it.

## Verify it worked

After editing `settings.php`, rebuild caches:

```bash
drush cr
```

Then upload a test file to a field (or set OSS as the default scheme and upload).
Confirm the file appears in your OSS bucket and that its URL resolves. If the
Flysystem UI is enabled, check **Reports → Flysystem** for the scheme's health
status.
