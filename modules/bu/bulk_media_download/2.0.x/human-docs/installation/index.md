# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Media** module (`media`), which Drupal enables automatically as a
  dependency.
- No third-party Composer or PHP library requirements.

> **Heads-up:** the shipped 2.0.x download is non-functional (the controller is a
> debug stub). Installing the module gives you the settings form, but the ZIP
> download will not work without a code fix. See the
> [overview](../index.md) and [Configuration](../configuration/index.md).

## Install with Composer

From the project root:

```bash
composer require drupal/bulk_media_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/bulk_media_download -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bulk_media_download -y
```

Both the settings form and the (currently broken) download endpoint require the
core **Administer site configuration** permission, so only administrators can
reach them. Next, see [Configuration](../configuration/index.md).
