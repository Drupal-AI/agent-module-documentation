# Installation

## Requirements

Snipper is lightweight and has no third‑party libraries. It needs:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1||^11`).
- Core's **Configuration Manager** module (`config`), which ships with Drupal and
  is enabled on standard installs.

There are no PHP extension or Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/snipper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/snipper -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en snipper -y
```

That is all it takes — there is no configuration to complete.

## Verify it worked

Go to **Configuration → Development → Configuration synchronization**
(`/admin/config/development/configuration`). If some configuration differs
between your active site and the sync directory, each listed item should now show
**Import**, **Export**, and **Download YML** links next to *View differences*.
