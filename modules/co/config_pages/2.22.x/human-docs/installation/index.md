# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Text** module (`text`) — Drupal enables it automatically as a
  dependency.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_pages -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/config_pages -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_pages -y
```

The module ships **no submodules**. To let editors manage config pages, grant the
relevant permissions — see the
[Configuration](../configuration/index.md#permissions) page for the full list.

## Next steps

Head to **Structure → Config pages** to create your first config page type — see
[Configuration](../configuration/index.md).
