# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **User** (`user`) module, which is always present.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/external_reset_password -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/external_reset_password -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en external_reset_password -y
```

## Verify it worked

The module doesn't do anything until you give it a URL, so the next step is
essential. Go to [Configuration](../configuration/index.md), enter your external
reset URL, and clear the cache. After that, trigger a password reset and confirm
you land on the external page rather than Drupal's own reset form.
