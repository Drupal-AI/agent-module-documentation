# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Language** module (`language`), which Drupal enables automatically as
  a dependency. Language filtering only makes sense on a site with more than one
  language configured.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/menu_manipulator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/menu_manipulator -W`, `ddev drush
> …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en menu_manipulator -y
```

There are no submodules. Once enabled, configure it at **Configuration → User
interface → Menu Manipulator** — see [Configuration](../configuration/index.md).
