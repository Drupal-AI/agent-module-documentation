# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- No third-party Composer or PHP libraries, and no other module dependencies.

This is version **2.0.0-alpha1** — an alpha release, so treat it as a
development-only tool and test before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/cacheviz -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/cacheviz -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en cacheviz -y
```

## Grant the permission

CacheViz provides its own permission. Go to **People → Permissions**
(`/admin/people/permissions`) and grant it only to the developer role you use
for debugging — remember it exposes internal cache metadata, so keep it off
public roles and prefer development or staging environments over production.
