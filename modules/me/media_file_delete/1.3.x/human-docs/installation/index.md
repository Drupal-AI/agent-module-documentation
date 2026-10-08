# Installation

## Requirements

- **Drupal 8.8+, 9, 10, 11, or 12** (`core_version_requirement: ^8.8 || ~9.0 ||
  ~10.0 || ^11 || ^12`).
- Core's **Media** (`media`) and **File** (`file`) modules — Drupal enables them
  automatically as dependencies.
- No third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_file_delete -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_file_delete -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_file_delete -y
```

The checkbox is added to the media delete forms immediately, with sensible,
safety‑first defaults.

## Submodule — protect files tracked by Entity Usage

If your site uses the [Entity Usage](https://www.drupal.org/project/entity_usage)
module to track where entities are referenced, enable the bundled submodule so
those references also protect files from deletion:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Media File Delete – Entity Usage** | `media_file_delete_entity_usage` | Plugs Entity Usage into the file‑usage resolver chain, so a file still referenced by a tracked entity is retained. |

```bash
drush en media_file_delete_entity_usage -y
```

It requires the Entity Usage module in addition to the base Media File Delete
module.

## Next steps

To set the checkbox default, enforce a policy, or grant the file‑delete permission,
see [Configuration](../configuration/index.md).
