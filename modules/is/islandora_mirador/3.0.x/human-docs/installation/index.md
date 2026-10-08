# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- **[Islandora](https://www.drupal.org/project/islandora) 2.x** (`drupal/islandora:^2`),
  including its **IIIF** submodule (`islandora_iiif`) — this is what serves the IIIF
  manifests the viewer reads.
- Core's **Block** (`block`) module.
- The **[Token](https://www.drupal.org/project/token)** module (`token`) — the
  manifest URL is a token pattern.

Composer pulls Islandora and Token in for you; make sure `islandora_iiif` is enabled
so manifests are available. A working Islandora media/node graph is needed for the
field formatter to resolve a node from a file.

## Install with Composer

From the project root:

```bash
composer require drupal/islandora_mirador -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/islandora_mirador -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en islandora_mirador -y
```

Enable the `islandora_iiif` and `block` dependencies too if they are not already on.

## After enabling

- Configure the viewer at **Configuration → Media → Mirador** — see
  [Configuration](../configuration/index.md).
- The module ships a migration that adds a **Mirador** display-hint term to the
  `islandora_display` vocabulary (used to place the viewer via Islandora Contexts).
  Import it when you're ready:

  ```bash
  ddev drush migrate:import islandora_mirador_tags
  ```
