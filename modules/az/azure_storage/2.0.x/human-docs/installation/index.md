# Installation

## Requirements

- **Drupal 8.8.3, 9, 10 or 11** (`core_version_requirement: ^8.8.3 || ^9 || ^10 ||
  ^11`).
- An **Azure Storage account** with a **Blob** container, and the account key or
  connection string for it.

There are no other module dependencies and no third‑party Composer or PHP library
requirements declared.

## Install with Composer

From the project root:

```bash
composer require drupal/azure_storage -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/azure_storage -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en azure_storage -y
```

After enabling, connect the module to your storage account — see
[Configuration](../configuration/index.md).
