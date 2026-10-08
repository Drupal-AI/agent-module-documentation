# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's AJAX dialog system, which ships with Drupal — no extra libraries to
  install.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/add_content_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/add_content_modal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en add_content_modal -y
```

After enabling, grant the **Manage add_content_modal settings** permission to the
roles that should be able to configure the behavior, then head to
[Configuration](../configuration/index.md) to choose which content types open in a
dialog. Nothing changes until you configure at least one content type there.
