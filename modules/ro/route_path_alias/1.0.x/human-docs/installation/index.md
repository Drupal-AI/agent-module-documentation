# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/route_path_alias -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/route_path_alias -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en route_path_alias -y
```

## Permissions

The module adds an **administer route path aliases** permission that controls who
can add and edit route aliases. Grant it only to trusted administrators at
**People → Permissions**.

## Verify it worked

Go to **Configuration → Search and metadata → URL aliases → Route aliases**
(`/admin/config/search/path/route-aliases`). If the page loads, the module is
installed. It ships with no aliases, so you'll start with an empty list — add your
first one from [Configuration](../configuration/index.md).
