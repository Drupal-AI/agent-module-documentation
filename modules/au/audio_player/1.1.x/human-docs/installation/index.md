# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Image** (`image`), **Field** (`field`) and **Media** (`media`)
  modules. Drupal enables these automatically as dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/audio_player -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/audio_player -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en audio_player -y
```

There is no separate settings page — configure the player on each field's
**Manage display** tab. See [How to use it](../index.md#how-to-use-it).
