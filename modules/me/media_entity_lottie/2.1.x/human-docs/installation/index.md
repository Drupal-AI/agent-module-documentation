# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency, and Drupal
  enables it automatically as a dependency when you turn on Media entity Lottie.
- **Outbound network access** for the player, or a local library override. The
  `<lottie-player>` and interactivity JavaScript are loaded from the unpkg CDN,
  so on an offline or locked‑down site you will want to override those libraries
  with a local copy.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_lottie -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_lottie -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_lottie -y
```

When it installs, the module copies a `lottie.png` thumbnail icon into your
site's media icon directory to use as the default thumbnail — nothing to do on
your part.

Enabling the module makes the **Lottie file** media source available, but it does
not create anything visible on its own yet. The next step is to create a media
type that uses that source — see [Configuration](../configuration/index.md).
