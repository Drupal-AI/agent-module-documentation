# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Field** module (`field`), which is part of the standard Drupal
  install and is enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/tablefield -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/tablefield -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en tablefield -y
```

Once enabled, **Table Field** becomes available as a field type when you add a
field to any content type or other fieldable entity.

## Submodules — enable only what you need

TableField ships two optional submodules. Enable them individually with
`drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Tablefield Cellspan** | `tablefield_cellspan` | Support for merging cells (colspan/rowspan) within a table. |
| **Tablefield Required** | `tablefield_required` | The ability to make individual table cells required. |

For example:

```bash
drush en tablefield_cellspan -y
```

Both submodules require the base TableField module, which is already present once
you have installed it above.
