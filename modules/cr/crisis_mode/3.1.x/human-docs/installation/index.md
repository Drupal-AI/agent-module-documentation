# Installation

## Requirements

- **Drupal 8.8 or newer**, including 9, 10, and 11
  (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- No other contributed modules, PHP extensions, or third‑party libraries are
  required.

## Install with Composer

From the project root:

```bash
composer require drupal/crisis_mode -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/crisis_mode -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en crisis_mode -y
```

Enabling the module adds a crisis block to the content region, but the block is
**disabled and shows nothing** on the site until you configure it and activate the
crisis situation. Nothing changes for visitors on install.

## Verify it worked

Go to **Configuration → System → Crisis mode**
(`/admin/config/system/crisis_mode`). If the settings form loads, the module is
installed correctly. From here you can write your message and, when needed,
activate it — see [Configuration](../configuration/index.md).
