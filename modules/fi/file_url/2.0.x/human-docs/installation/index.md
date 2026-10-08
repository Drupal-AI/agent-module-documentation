# Installation

## Requirements

File URL is lightweight. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`) — the only dependency, and Drupal enables it
  automatically when you turn on File URL.

There are no third-party Composer packages or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_url -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/file_url -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_url -y
```

That's all. There is no settings form to visit — head to any content type's
**Manage fields** tab and add a **File URL** field. See
[How to use it](../index.md#how-to-use-it) for the field, widget, and formatter
options.

This module ships no submodules.
