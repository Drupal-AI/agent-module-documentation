# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Toolbar** module (`toolbar`).
- The contrib **[Admin Toolbar](https://www.drupal.org/project/admin_toolbar)**
  module and its **Admin Toolbar Tools** submodule (`admin_toolbar`,
  `admin_toolbar_tools`) — hard dependencies, pulled in by Composer.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/seeds_toolbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies — including Admin Toolbar — as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/seeds_toolbar -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en seeds_toolbar -y
```

This also enables Toolbar, Admin Toolbar, and Admin Toolbar Tools if they are not
already on. The restyled vertical toolbar is active immediately for anyone with
core's *Access toolbar* permission. It ships with sensible defaults (dark style,
compact, search enabled); adjust them in [Configuration](../configuration/index.md).

> **Tip:** if the new styling doesn't appear right away, clear caches
> (`drush cr`).

## Verify it worked

Log in as an administrator and reload any admin page. The toolbar should now be a
vertical side panel rather than the default horizontal bar. You should also find
the settings form at **Configuration → User interface → Seeds Toolbar**.
