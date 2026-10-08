# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on this module.
- *Optional:* the [Linkit](https://www.drupal.org/project/linkit) module if you want
  the rich‑text download substitutions. Note the module conflicts with Linkit older
  than 6.0.1, so use a current Linkit release.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_download -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_download -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_download -y
```

Once enabled, the `/media/{media}/download` route exists immediately. Before anyone
can use it, grant the **`download media`** permission and add download links where
you need them — see [How to use it](../index.md#how-to-use-it).

There are no submodules.
