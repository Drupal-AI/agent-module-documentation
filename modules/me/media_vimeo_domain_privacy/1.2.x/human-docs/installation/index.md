# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- Core's **Media** module (`media`) enabled — the only dependency, and Drupal will
  enable it automatically as a dependency when you turn on this module.
- On the Vimeo side: a video with **domain‑level privacy** configured, and your
  site's domain added to that video's allowed‑domains list in Vimeo.

There are no third‑party Composer or PHP library requirements. The project's own
notes state there are no special requirements to use it.

## Install with Composer

From the project root:

```bash
composer require drupal/media_vimeo_domain_privacy -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_vimeo_domain_privacy -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_vimeo_domain_privacy -y
```

There is no configuration step — the module works as soon as it is enabled.

## Verify it worked

Add a new **Remote video** media item (**Content → Media → Add media**) and paste
the URL of a Vimeo video that uses domain‑level privacy. If the item saves with its
title and thumbnail populated — rather than failing with an oEmbed/metadata error —
the module is doing its job.
