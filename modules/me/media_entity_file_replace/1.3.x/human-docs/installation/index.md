# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Media** module (`media`) — the one dependency, which Drupal enables
  automatically when you turn this module on.
- No third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_file_replace -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_file_replace -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_file_replace -y
```

There is no settings form. The final step is to enable the **Replace file**
widget on each media type's **Manage form display** where you want it — see the
[overview](../index.md#how-to-use-it).

## Submodules

Media Entity File Replace ships no submodules.
