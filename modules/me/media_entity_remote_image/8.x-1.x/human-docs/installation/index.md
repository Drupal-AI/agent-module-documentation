# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  Note this branch is a **beta** (`8.x-1.2-beta2`), so test before relying on it in
  production.
- Drupal core's **Media** module (`media`, version 8.4 or newer) and **Link**
  module (`link`), which Drupal enables automatically as dependencies.

There are no third‑party PHP libraries to install. Local thumbnail generation, if
you enable it, requires the remote image to be reachable by your site and
processable by the configured image toolkit (AVIF thumbnails in particular depend
on toolkit/PHP support).

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_remote_image -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_remote_image -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_remote_image -y
```

Core's Media and Link modules are enabled automatically if they are not already
on.

## Verify it worked

Go to **Structure → Media types** (`/admin/structure/media`) and confirm a
**Remote image** media type is listed. Then visit the module's settings at
**Configuration → Media → Media Remote Image settings**
(`/admin/config/media/media-entity-remote-image-settings`) to confirm the form
loads. The [Configuration](../configuration/index.md) page covers what to set
there.
