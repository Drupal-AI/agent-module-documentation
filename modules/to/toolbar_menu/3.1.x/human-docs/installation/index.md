# Installation

## Requirements

Toolbar Menu is lightweight:

- **Drupal 9.2, 10, or 11** (`core_version_requirement: ^9.2 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`) enabled — the only dependency, enabled
  automatically.
- No third-party library requirements.

**Suggested:** [Admin Toolbar](https://www.drupal.org/project/admin_toolbar)
(`admin_toolbar`) — not required, but it makes the overall toolbar experience
richer.

## Install with Composer

From the project root:

```bash
composer require drupal/toolbar_menu -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/toolbar_menu -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en toolbar_menu -y
```

Drupal enables the core `toolbar` dependency for you if it is not already on.

Once enabled, head to **Configuration → User interface → Toolbar Menu**
(`/admin/config/user-interface/toolbar-menu/elements`) to add your first menu —
see [Configuration](../configuration/index.md).
