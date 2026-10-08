# Installation

## Requirements

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **Node** module (`node`) enabled — this is a dependency, and Drupal enables
  it automatically as needed. The per‑type setting applies to node content types.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/admin_theme_by_content_type -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/admin_theme_by_content_type -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en admin_theme_by_content_type -y
```

Once enabled, edit any content type under **Structure → Content types**
(`/admin/structure/types`) to choose whether that type's add/edit forms use the admin
theme or the front‑end theme.
