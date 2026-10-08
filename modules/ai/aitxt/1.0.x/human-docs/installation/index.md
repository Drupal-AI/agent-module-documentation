# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).

There are no third‑party Composer, PHP library, or external‑service
requirements — this module simply generates and serves a text file.

## Install with Composer

From the project root:

```bash
composer require drupal/aitxt -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/aitxt -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en aitxt -y
```

Once enabled, edit the file's contents on the settings form — see
[Configuration](../configuration/index.md).
