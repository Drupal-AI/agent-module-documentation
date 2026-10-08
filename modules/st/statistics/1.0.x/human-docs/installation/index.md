# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- **PHP 8.1.6 or newer**.
- Core's **Node** module (`node`) — the only module dependency, and it's almost
  always already on. Drupal enables it automatically if needed.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/statistics -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Upgrading from core?** On Drupal versions where Statistics was still in core,
> it lived at the same machine name (`statistics`). Requiring the contrib project
> replaces the core version cleanly — your existing `node_counter` data is
> preserved.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/statistics -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en statistics -y
```

Remember that enabling the module does **not** start counting — view counting is
off until you tick the setting. Head to
[Configuration](../configuration/index.md) to turn it on.

Statistics has no submodules.
