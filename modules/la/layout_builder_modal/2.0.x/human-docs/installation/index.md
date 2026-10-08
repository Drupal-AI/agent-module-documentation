# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`; the
  Composer constraint targets `^9.5 || ^10.2 || ^11`).
- Core's **Layout Builder** (`layout_builder`) and **System** (`system`, 8.7.0 or
  newer) modules. Layout Builder is enabled automatically as a dependency; System
  is always present.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/layout_builder_modal -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layout_builder_modal -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layout_builder_modal -y
```

That is all it takes — the modal behavior is active immediately for anyone editing
a layout with Layout Builder. There is no required configuration; if you want to
adjust the dialog size or theme, see [Configuration](../configuration/index.md).
There are no submodules.
