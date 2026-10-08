# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **User** module (`user`) — part of every standard install.
- The **Webform** module, version **6.2 or newer** (`drupal/webform:^6.2`). Composer
  pulls this in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/webform_user_registration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
(including Webform) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/webform_user_registration -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en webform_user_registration -y
```

There are no submodules. Once enabled, the **User Registration** handler becomes available
to add to any webform — continue to [Configuration](../configuration/index.md).
