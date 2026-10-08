# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No third‑party Composer packages, PHP libraries, or contrib module
  dependencies.

Note this project is **not covered by the security advisory policy**.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_display_modes_listing -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_display_modes_listing -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_display_modes_listing -y
```

## Verify it worked

Go to **Structure → Content types** (`/admin/structure/types`) and open the
operations dropdown for a content type that has more than one active display mode.
You should now see those additional display modes listed as their own operation
links.
