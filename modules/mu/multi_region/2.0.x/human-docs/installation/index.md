# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Language** module (`language`) — this is a dependency, and Drupal
  enables it automatically. Regions are built on top of your configured languages.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/multi_region -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/multi_region -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en multi_region -y
```

Drupal enables the **Language** dependency at the same time.

## Verify it worked

Go to **Configuration → Regional and language**. You should see a **Regions**
option where you can define regions and assign languages to them. If it is there,
the module is installed — continue with [Configuration](../configuration/index.md).
