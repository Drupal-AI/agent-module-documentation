# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module (`node`).
- Core's **Content translation** module (`content_translation`) — the per-language
  assignment feature builds on it.

Both dependencies ship with Drupal core; Drupal will enable them automatically as
needed. There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/editorial_access_manager -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/editorial_access_manager -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en editorial_access_manager -y
```

## Verify it worked

Log in as an administrator and open **Configuration → Content authoring →
Editorial access manager** (`/admin/config/content/editorial-access-manager`). If
the form listing content entity types loads, installation succeeded. The feature
does nothing until you enable it for the entity types and bundles you want and
assign the permissions — see [Configuration](../configuration/index.md).
