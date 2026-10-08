# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **Purge** module (`purge`) — this module is a purger plugin for it.
- The **Key** module (`key`) — used to store the Cloudflare API token securely.
- A **Cloudflare account** with an API token that has the **Purge** permission for
  your zone.

Both the Purge and Key modules are installed automatically when you require this
module with Composer. The 1.0.x branch is a beta release.

## Install with Composer

From the project root:

```bash
composer require drupal/cloudflare_purger -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies — including Purge and Key — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cloudflare_purger -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cloudflare_purger -y
```

This also enables Purge and Key if they were not already on.

## Verify it worked

Go to the Purge configuration at **Configuration → Development → Performance →
Purge** (`/admin/config/development/performance/purge`) and confirm that
**Cloudflare** appears as an available purger you can add. Actually wiring it up is
covered in [Configuration](../configuration/index.md).
