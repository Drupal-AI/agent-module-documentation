# Installation

## Requirements

Synapse Staff needs:

- **Drupal 8, 9, 10 or 11** (`core_version_requirement: ^8||^9||^10||^11`).

There are no third-party module, Composer or PHP library dependencies listed.

Because Synapse Staff is a vendor/site-specific customization module, it is most
at home within the Synatix/Synapse stack it was built for. If you are installing
it outside that context, review what it does before enabling it on a production
site.

## Install with Composer

From the project root:

```bash
composer require drupal/synapse -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/synapse -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en synapse -y
```

## Verify it worked

After enabling, open the Synapse settings form (the `synapse.settings` route) to
confirm the module is present and to configure the Google Tag Manager and
site-verification options — see [Configuration](../configuration/index.md).
