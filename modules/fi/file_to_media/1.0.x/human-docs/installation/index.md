# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ~9.0 || ^10 || ^11`).
- Core's **File**, **Media**, and **Views** modules — enabled automatically as
  dependencies. You will also want at least one **media type** whose source field
  accepts the file extensions you plan to convert.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/file_to_media -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/file_to_media -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en file_to_media -y
```

## Submodules

File to Media ships no submodules.

## Next steps

There is no settings form. You use the module by adding its **File to Media links**
field to a View of files — see [How to use it](../index.md#how-to-use-it) in the
overview.
