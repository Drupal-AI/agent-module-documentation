# Installation

## Requirements

- **Drupal 8.8, 9, or 10** (`core_version_requirement: ^8.8.0 || ^9 || ^10`).
- Core's **User**, **Block**, **Taxonomy**, and **Node** modules — all enabled by
  default on a standard Drupal site.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/emn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/emn -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en emn -y
```

No configuration is needed — the module works immediately.

## Verify it worked

Go to **Structure → Content types** (`/admin/structure/types`). You should now see
a **Machine name** column in the list. Check the taxonomy vocabularies overview,
**People → Roles** (`/admin/people/roles`), and the block layout page too — each
gains a machine‑name (or plugin‑ID) column.
