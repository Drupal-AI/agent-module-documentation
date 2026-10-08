# Installation

## Requirements

- **Drupal 8 or newer** (`core_version_requirement: >=8`).
- Core's **Path alias** module (`path_alias`) — the module resolves aliased
  request paths to their internal path before matching, so this is required and is
  enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/advanced_cors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/advanced_cors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en advanced_cors -y
```

## Next steps

Nothing happens until you create at least one CORS policy — a freshly enabled
module sends no extra headers. Head to **Configuration → Web services → CORS
Settings** (`/admin/config/services/advanced_cors`) to add your first policy;
the [Configuration](../configuration/index.md) guide covers every field and the
security caveats. There are no submodules.
