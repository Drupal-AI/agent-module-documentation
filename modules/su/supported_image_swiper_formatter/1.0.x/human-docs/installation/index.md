# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **Supported Image** (`supported_image`) — the field type this formatter displays.
- **Swiper formatter** (`swiper_formatter`) — the Swiper.js carousel integration
  this builds on.
- No third-party Composer packages or PHP libraries beyond those modules.

Composer pulls in the two module dependencies for you when you require this module.

## Install with Composer

From the project root:

```bash
composer require drupal/supported_image_swiper_formatter -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed — including Supported Image and Swiper formatter.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/supported_image_swiper_formatter -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en supported_image_swiper_formatter -y
```

Drush enables the required Supported Image and Swiper formatter modules alongside
it.

## Verify it worked

On the **Manage display** page of an entity that has a Supported Image field, the
field's format select should now offer **Swiper images**.

> **Note:** This release is a beta (1.0.0-beta1) and is not covered by Drupal's
> security advisory policy. Review it before relying on it in production.
