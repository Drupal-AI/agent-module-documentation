# Installation

## Requirements

Flysystem Amazon S3 relies on the Flysystem module and the AWS PHP SDK:

- **Drupal 11** (`core_version_requirement: ^11`).
- **[Flysystem](https://www.drupal.org/project/flysystem)** `^2.3` (`flysystem`) — the
  base module that turns a scheme into a stream wrapper.
- Third‑party PHP libraries, pulled in by Composer automatically:
  - `aws/aws-sdk-php` `^3.288.1`
  - `league/flysystem` `^1.0.20`
  - `league/flysystem-aws-s3-v3` `^1.0` (excluding `1.0.12` and `1.0.13`)

Because these libraries are required in the module's `composer.json`, installing with
Composer (below) brings them in for you — do **not** download the module as a zip, or
the AWS SDK will be missing.

## Install with Composer

From the project root:

```bash
composer require drupal/flysystem_s3 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Flysystem, the AWS
SDK, and any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/flysystem_s3 -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en flysystem_s3 -y
```

Drupal enables Flysystem at the same time if it is not already on.

Enabling the module does not, by itself, send any files to S3 — nothing happens until
you declare a scheme in `settings.php`. Continue to
[Configuration](../configuration/index.md).

## Grant the CORS upload permission (optional)

If you plan to use direct browser‑to‑S3 uploads, grant the **Use S3 CORS upload**
permission at **People → Permissions** (`/admin/people/permissions`) to the roles that
should have it. This permission is a trusted capability — it lets a user obtain signed
write access to your bucket path — so grant it only to roles you trust. On its own the
permission does nothing until a scheme has CORS enabled (see Configuration).
