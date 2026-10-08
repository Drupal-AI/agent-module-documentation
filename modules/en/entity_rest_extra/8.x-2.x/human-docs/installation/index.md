# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Serialization** (`serialization`) module.
- The contributed **REST UI** (`restui`) module — used to enable and secure the
  REST resources. Composer will pull it in with the `-W` flag below.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_rest_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install and update
dependencies such as REST UI.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_rest_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_rest_extra -y
```

Enable REST UI too if it is not already on:

```bash
drush en restui -y
```

## Verify it worked

Go to **Configuration → Web services → REST**
(`/admin/config/services/rest`) — the resources added by Entity REST Extra
(bundles, fields, view modes) should be listed and available to enable. See the
"How to use it" section of the [overview](../index.md) for enabling them safely,
including choosing authentication and granting the `restful get …` permissions to
trusted roles only.
