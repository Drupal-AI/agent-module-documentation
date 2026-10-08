# Installation

## Requirements

Media Entity Link needs:

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- Core's **Media**, **Media Library**, **Link**, **Image**, and **Path** modules
  enabled — these are the dependencies, and Drupal enables them automatically.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_entity_link -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_link -y
```

On enable, the module installs a complete **Link** media type — including its URL
source field and default form/view displays — so it's ready to use with no
configuration. See [How to use it](../index.md#how-to-use-it) to start creating
Link media.
