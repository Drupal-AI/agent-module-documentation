# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The administration **toolbar** in use, since the flush button is added to it.
- No other modules, third-party Composer packages, or PHP libraries are required.

## Install with Composer

From the project root:

```bash
composer require drupal/cacheflusher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cacheflusher -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cacheflusher -y
```

## Grant the permission

CacheFlusher ships its own permission controlling who sees the flush button. After
enabling the module, go to **People → Permissions** and grant it only to trusted
administrator roles — a full cache clear affects performance for everyone while the
caches rebuild, so it should not be widely available.
