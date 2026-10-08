# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Locale** module (`locale`) — Drupal enables it automatically as a
  dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/cyrillic_to_latin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cyrillic_to_latin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cyrillic_to_latin -y
```

## Verify it worked

Go to **Configuration → Regional and language → Cyrillic to Latin**
(`/admin/config/regional/cyrillic-to-latin`) and confirm the settings form loads.
From there you can enable or disable the on‑the‑fly conversion — see
[Configuration](../configuration/index.md).
