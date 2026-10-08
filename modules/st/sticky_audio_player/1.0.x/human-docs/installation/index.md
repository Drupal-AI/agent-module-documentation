# Installation

## Requirements

Sticky Audio Player needs:

- **Drupal 11.2 or newer** (`core_version_requirement: ^11.2`).
- Core's **File** (`file`) and **Media** (`media`) modules, which Drupal enables as
  dependencies.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/sticky_audio_player -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/sticky_audio_player -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en sticky_audio_player -y
```

## After installing

There is no settings page. To use the player, set it as the display format for an
entity reference field that targets audio Media entities, on your content type's
**Manage display** screen. The [main guide](../index.md) walks through those steps.
