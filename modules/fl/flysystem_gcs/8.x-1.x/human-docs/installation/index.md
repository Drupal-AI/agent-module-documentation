# Installation

## Requirements

Flysystem Google Cloud Storage needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  Note this is a beta release; test on a copy before using it in production.
- The **Flysystem** module (`flysystem`) enabled — the required dependency that
  provides the stream-wrapper framework.
- The **Flysystem Adapter for Google Cloud Storage** PHP library, which Composer
  pulls in as a dependency.
- A **Google Cloud project**, a **GCS bucket**, and a **service account** with
  the *Storage Admin* role, plus a downloaded **JSON key** for that account.

### Prepare Google Cloud first

1. Create a project in the Google Cloud Platform console.
2. Create a bucket in the Cloud Storage browser.
3. Create a service account and give it the *Storage Admin* role.
4. Create a new **JSON** key for that service account and download it.
5. Place the JSON key file in a **private, non-web-accessible** folder on your
   site's server.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem_gcs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the GCS adapter
library and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flysystem_gcs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem_gcs -y
```

Enabling the module registers the `gcs` driver with Flysystem, but nothing is
stored on GCS yet — you must define a scheme in `settings.php` first.

## Configure the scheme in settings.php

This module has no admin form; the storage scheme lives in `settings.php`. See
"How to use it" in the [guide overview](../index.md) for a complete example. In
short: add an entry to `$settings['flysystem']` with your bucket, project ID, and
service-account key path, then switch the default download method and/or existing
fields to the new scheme.

### Keep your service-account key out of version control

The service-account JSON key is a **secret**. Do not commit it, and do not paste
its path into a committed `settings.php` as a literal string if you can avoid it:

- Store the key file in a private directory outside the web root.
- Put the path in an environment variable (for DDEV:
  `ddev dotenv set .ddev/.env --gcs-key-file-path=<path>`, then `ddev restart`).
- Read it in `settings.php` with `getenv('GCS_KEY_FILE_PATH')`.
- Never commit `.ddev/.env` or the JSON key itself.

## Verify it worked

After editing `settings.php`, rebuild caches:

```bash
drush cr
```

Then upload a test file to a field configured to use the GCS scheme (or set GCS
as the default and upload). Confirm the file appears in your bucket and that its
URL resolves. Check image derivative generation and private-file downloads too,
since those exercise more of the adapter.
