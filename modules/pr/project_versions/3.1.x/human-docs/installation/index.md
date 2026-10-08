# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- No other contrib modules and no third‑party Composer or PHP libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/project_versions -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/project_versions -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en project_versions -y
```

On enable, the module automatically generates the two random secrets it needs — a URL
token and an encryption key — so the endpoints are ready immediately (there are no
placeholder values left in a real install). There are no submodules.

Next, open **Configuration → System → Project Versions**
(`/admin/config/system/project-versions`) to copy the generated URL token and
encryption key into your external collector — see the
[overview](../index.md#where-it-lives-in-the-admin-menu).
