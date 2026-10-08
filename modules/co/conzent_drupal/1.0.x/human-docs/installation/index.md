# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **PHP 8.1** or newer.
- A **Conzent account** to obtain a Website Key — sign up on the Conzent dashboard.
  For self‑hosted use you also need a Conzent (OCI) server URL.

There are no additional module dependencies or third‑party PHP/JavaScript library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/conzent_drupal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/conzent_drupal -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en conzent_drupal -y
```

## Verify it worked

Go to **Configuration → System → Conzent CMP** (`/admin/config/system/conzent`).
If you can open the settings form, the module is installed. The banner will not
appear on the front end until you paste a valid website key — continue to
[Configuration](../configuration/index.md).
