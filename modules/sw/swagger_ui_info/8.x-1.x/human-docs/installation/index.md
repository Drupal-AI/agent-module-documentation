# Installation

## Requirements

- **Drupal 9.4, 10, or 11** (`core_version_requirement: ^9.4 || ^10 || ^11`).
- No other module dependencies, no submodules, and no PHP or JavaScript library
  requirements.

Note that this project is **not covered by Drupal's security advisory policy**, so
weigh that when deciding whether to rely on it.

## Install with Composer

From the project root:

```bash
composer require drupal/swagger_ui_info -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/swagger_ui_info -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en swagger_ui_info -y
```

## Verify it worked

Visit `/swagger_info`. Out of the box the module can render its bundled example
spec, so you should see the Swagger UI explorer. To show your own API, upload your
spec file — see [Configuration](../configuration/index.md).
