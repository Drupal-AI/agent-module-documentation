# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- The **`nicebooks/isbn`** PHP library (version below 0.7). This is a hard
  requirement — the module checks for it and reports an error if it's missing.
  Composer installs it automatically when you require the module.
- No other contributed modules are required. (The **Feeds** module is only needed
  if you want to use the bundled ISBN Feeds target during imports.)

## Install with Composer

From the project root:

```bash
composer require drupal/isbn -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and it brings in the required `nicebooks/isbn` library.
Installing via Composer is important here — the module will not function without
that library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/isbn -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en isbn -y
```

There are **no submodules** and no configuration step. Once enabled, the **ISBN**
field type is available to add to any entity bundle — see
[How to use it](../index.md#how-to-use-it).
