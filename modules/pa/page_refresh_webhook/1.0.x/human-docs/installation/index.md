# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** module (`node`) — enabled by default on a standard install.
- The contributed **[Key](https://www.drupal.org/project/key)** module (`key`),
  used to store the API key securely. Composer pulls it in automatically.

## Install with Composer

From the project root:

```bash
composer require drupal/page_refresh_webhook -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
and bring in the Key module.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/page_refresh_webhook -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en page_refresh_webhook -y
```

This also enables the Key module if it is not already on.

## Verify it worked

After configuring an endpoint and content types (see
[Configuration](../configuration/index.md)), save a node of a watched content type
and confirm your endpoint receives the POST request.
