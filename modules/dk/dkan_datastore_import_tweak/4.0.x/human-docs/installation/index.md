# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- A working **DKAN** site with the **datastore** submodule (`dkan_datastore`)
  enabled. DKAN's datastore submodule is **not** enabled automatically, so enable
  it yourself before this module.
- For the MySQL‑import submodule: DKAN's **datastore_mysql_import** module.

There are no third‑party Composer library or PHP extension requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/dkan_datastore_import_tweak -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/dkan_datastore_import_tweak -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure DKAN's datastore is on, then enable this module:

```bash
drush en dkan_datastore -y
drush en dkan_datastore_import_tweak -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **MySQL import tweak** | `dkan_datastore_mysql_import_tweak` | Applies the same configured delimiter to DKAN's faster MySQL importer (`datastore_mysql_import`) `LOAD DATA` path. Enable it if you use the MySQL importer. |

```bash
drush en dkan_datastore_mysql_import_tweak -y
```

## Verify it worked

Go to **`/admin/dkan/parser-settings`**. You should see the parser settings form
with delimiter and quote dropdowns. Set them to match your source files, save, and
re‑import a dataset — the columns should now split correctly. Continue to
[Configuration](../configuration/index.md) for the details of each option.
