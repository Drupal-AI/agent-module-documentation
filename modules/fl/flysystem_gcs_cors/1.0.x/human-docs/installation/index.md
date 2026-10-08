# Installation

## Requirements

Flysystem GCS CORS needs:

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- **Flysystem GCS** (`flysystem_gcs`) enabled and configured — this module reuses
  its stream wrapper and bucket configuration.
- The **Token** module (`token`), a required dependency.
- A **GCS bucket** with a service account whose credentials are configured for
  Flysystem GCS.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem_gcs_cors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Flysystem GCS,
Token, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/flysystem_gcs_cors -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem_gcs_cors -y
```

## Configure the GCS stream wrapper and service account

Before the CORS upload can work you must:

1. **Configure the Flysystem GCS stream wrapper in `settings.php`** — see the
   [Flysystem GCS installation guide](../../../fl/flysystem_gcs/8.x-1.x/human-docs/installation/index.md).
2. **Grant the service account the required roles**:
   - `roles/storage.admin` on the GCS bucket.
   - `roles/iam.serviceAccountTokenCreator` on the service account itself (this
     is what lets it mint the short-lived signed upload URLs).

Keep the service-account credentials and signing key stored as **secrets** —
never commit them. Use environment variables and reference them from
`settings.php` with `getenv()`, as described in the Flysystem GCS guide.

## Finish in the admin UI

Go to **Configuration → Media → GCS CORS** (`/admin/config/media/gcs-cors`), enter
your website URL, and save. This applies a CORS rule to the bucket for that
origin. See [Configuration](../configuration/index.md) for details.

## Verify it worked

Add or edit a file field whose upload destination is the Flysystem GCS stream
wrapper, then upload a large file as a user who holds the module's upload
permission. The upload should go directly from the browser to the bucket (you can
confirm in your browser's network tools that the file bytes are sent to Google
Cloud Storage, not to your Drupal server), and the file should appear in the
bucket.
