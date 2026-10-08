# Installation

## Requirements

- **Drupal 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12`). Earlier
  Drupal versions are no longer supported — use the 2.1.x branch for those.
- Core's **File** module (`file`), which provides the file field the entity uses.
  It is the only dependency and Drupal enables it automatically as a dependency.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/path_file -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/path_file -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en path_file -y
```

When it installs, the module grants the **View published path file entity
entities** permission to both the anonymous and authenticated roles, so published
downloads work for everyone right away. If you want private downloads, revoke
that permission afterward (see the permissions section on the
[overview page](../index.md#control-who-can-do-what)).

## After enabling

There's nothing else you must configure. Head to **Content → Path files** to
create your first download, and to **Content → Path files → Settings** if you
want to adjust the allowed file extensions. Both are covered on the
[overview page](../index.md#how-to-use-it).
