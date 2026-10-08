# Installation

## Requirements

- **Drupal 11 or 12** (`core_version_requirement: ^11 || ^12`).
- A **Google Cloud Platform** account with a Storage bucket and a service account
  that can access it.
- **Bear in mind this module is in early, non‑production development** — see the
  warning on the [overview page](../index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/gcs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gcs -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en gcs -y
```

## Supply your Google Cloud credentials

The module needs a Google Cloud service‑account credential to reach your bucket.
Store it as a secret — an environment variable or a mounted key file — rather than
committing it. With DDEV you can hold the value in an environment variable:

```bash
ddev dotenv set .ddev/.env --google-application-credentials=<path-or-value>
ddev restart
```

Never commit `.ddev/.env` or the key file, and scope the service account to just
the bucket it needs.

## Verify it worked

Log in as an administrator and confirm **GCS** appears as enabled on the
**Extend** page (`/admin/modules`). Given the module's experimental status, test
file uploads carefully on a non‑production environment before relying on it.
