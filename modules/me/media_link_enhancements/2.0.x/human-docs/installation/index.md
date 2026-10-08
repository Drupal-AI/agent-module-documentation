# Installation

## Requirements

Media Link Enhancements builds on core Media:

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Media** module (`media`) enabled — the only hard dependency, enabled
  automatically as a dependency when you turn on this module.
- Core Media's **Standalone media URL** setting must be **enabled**
  (`/admin/config/media/media-settings`); several features rely on the
  `/media/{id}` canonical route existing. The settings form warns you if it is off.
- **Optional:** the **Linkit** module (`drupal/linkit`) if you want a WYSIWYG /
  link-field UI for selecting media to link — the module ships a Linkit matcher for
  this.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_link_enhancements -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/media_link_enhancements -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_link_enhancements -y
```

Every feature is off after install. Enable **Standalone media URL** in core Media's
settings if you have not already, then configure the features on the settings form —
see the "How to use it" section of the [overview](../index.md).

There are no submodules.
