# Installation

## Requirements

Config Merge has very light requirements:

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.0 or newer** (`php: >=8.0`).

The parent module has no module dependencies of its own. The optional
**Config Merge Filter** submodule (see below) works with the
[Config Filter](https://www.drupal.org/project/config_filter) module, so install
that as well if you want the automatic-merge-on-import behaviour.

There are no other third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/config_merge -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/config_merge -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en config_merge -y
```

That's all it takes for the merge library itself. There is nothing to configure —
the parent module is a library plus an event that other code uses.

## Submodule — enable only if you want automatic merges on import

Config Merge ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Config Merge Filter** | `config_merge_filter` | A [Config Filter](https://www.drupal.org/project/config_filter) plugin that runs the three-way merge during configuration import, so imported config is merged against your active configuration instead of overwriting it. Requires the Config Filter module. |

Enable it with:

```bash
drush en config_merge_filter -y
```
