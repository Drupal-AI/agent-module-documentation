# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency.
- A **Make (make.as) account** with API access, so you can obtain a User ID and
  API Key.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/make -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/make -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en make -y
```

## Verify it worked

Go to **Configuration → Web services → Make** (`/admin/config/services/make`).
If the settings form loads, the module is installed and ready for your
credentials — continue to [Configuration](../configuration/index.md).
