# Installation

## Requirements

- **Drupal 10.1/10.3 or 11** (the module's info declares
  `core_version_requirement: ^10.1 || ^11`, and Composer requires
  `drupal/core: ^10.3 || ^11`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **File** (`file`) and **Media** (`media`) modules — the only
  dependencies, enabled automatically as dependencies.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/media_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_download -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_download -y
```

There is **no configuration form, no permissions and no submodules**. As soon as
the module is enabled, `/media/{id}` serves the source file directly (see
[How to use it](../index.md#how-to-use-it)). The module also forces core's
"standalone media URL" setting on while it is installed, so those URLs always
resolve.

## Verify it worked

Visit `/media/{id}` for a media item that has a downloadable source file (as a
user with **view media** access). The browser should receive the file itself —
inline by default, or as a forced download if you add `?dl=1`.
