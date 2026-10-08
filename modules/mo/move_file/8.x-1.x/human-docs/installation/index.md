# Installation

## Requirements

- **Drupal 9.1 or 10** (`core_version_requirement: ^9.1 || ^10`).
- Core's **Node**, **File**, and **Taxonomy** functionality (used directly; no
  contrib module dependencies are declared).
- Optional but common companion: the
  [Private files download permission](https://www.drupal.org/project/private_files_download_permission)
  module, if you want moving files between public/private directories to change
  who can download them.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/move_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/move_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en move_file -y
```

Enabling the module adds its configuration UI but changes nothing until you tell
it which content types/fields to act on and map terms to directories. See
[Configuration](../configuration/index.md).

## Verify it worked

Confirm the module is enabled:

```bash
drush pm:list --status=enabled | grep move_file
```

Then, after configuring it (next page), save a node with a file and a mapped term
and confirm the file has moved to the expected directory (check the file's path,
for example under **Content → Files** if you have the Files listing available).
