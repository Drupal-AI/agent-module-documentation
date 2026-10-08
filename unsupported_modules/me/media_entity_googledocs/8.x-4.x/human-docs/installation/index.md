# Installation

## Requirements

- **Drupal 8 or 9** (`core_version_requirement: ^8 || ^9`). Confirm your site's
  core version is in range before deploying this branch.
- Drupal core's **Media** module (`media`), which Drupal enables automatically as
  a dependency.

There are no contributed‑module dependencies, no API keys, and no third‑party PHP
libraries to install.

## Install with Composer

From the project root:

```bash
composer require drupal/media_entity_googledocs -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/media_entity_googledocs -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_entity_googledocs -y
```

Core's Media module is enabled automatically if it is not already on.

## Verify it worked

Go to **Structure → Media types → Add media type**
(`/admin/structure/media/add`) and confirm that **GoogleDocs** appears in the
**Media source** dropdown. Full step‑by‑step setup, including choosing the display
formatter, is in the [main guide](../index.md).
