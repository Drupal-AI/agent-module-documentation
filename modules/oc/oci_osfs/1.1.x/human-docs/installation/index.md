# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- The **AWS SDK for PHP** (`aws/aws-sdk-php`) — you do **not** install this
  separately; Composer pulls it in automatically as a dependency.
- An **OCI Object Storage** bucket and credentials: your region, namespace, bucket
  name, and one supported authentication method (Customer Secret Keys, an OCI API
  key, or instance principals on an OCI Compute host).

## Install with Composer

From the project root:

```bash
composer require drupal/oci_osfs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the AWS SDK and any
other shared dependencies alongside the module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oci_osfs -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oci_osfs -y
drush cr
```

## Verify it worked

Check that the module's routes registered:

```bash
drush route | grep oci_osfs
```

You should see the settings page (`/admin/config/media/oci-osfs`), the actions page
(`/admin/config/media/oci-osfs/actions`), and the image‑style route. Then head to
[Configuration](../configuration/index.md) to enter your credentials, and use the
**Validate Configuration** action on the Actions page to confirm Drupal can reach
your bucket.
