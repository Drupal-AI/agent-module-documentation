# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency. Drupal will
  enable it as a dependency automatically. In practice you will also want core's
  **Media Library** module for the "Add media" flow, though it is not strictly
  required.

There are no third-party PHP library or Composer requirements. To embed *real*
posts you will additionally need Facebook App credentials and outbound network
access (see [Configuration](../configuration/index.md)) — but installing and
wiring up the media type does not.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_instagram -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_instagram -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_instagram -y
```

The module ships no submodules. Enabling it makes the **Instagram** source
(`oembed:instagram`) and the **instagram_embed** formatter available to core
Media; next, head to [Configuration](../configuration/index.md) to add your
credentials and create an Instagram media type.
