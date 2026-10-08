# Installation

## Requirements

- **Drupal 10.1+ or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Media: Acquia DAM** (`media_acquiadam`) — the base integration that holds the
  Acquia DAM connection and credentials. This importer builds directly on it.
- The **Token** module (`token`).
- An **Acquia DAM (Widen) account** with API credentials, configured in
  `media_acquiadam`.

Drupal enables the module dependencies for you. The module's own documentation also
notes it works alongside **Views Remote Data** (`views_remote_data`) for surfacing
DAM data — install that too if your workflow needs it.

> **Note:** this is a **beta** release (2.0.x, `2.0.0-beta2`). Test the import on a
> non-production environment before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/acquiadam_asset_import -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Media: Acquia DAM,
Token and update shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquiadam_asset_import -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquiadam_asset_import -y
```

This also enables `media_acquiadam` and `token` if they are not already on.

## Set up the Acquia DAM connection first

The importer has nothing to import until the **Acquia DAM connection is configured
in `media_acquiadam`**. In that base module, enter and authenticate your Acquia DAM
(Widen) API credentials — keep them as **secrets** (an environment variable, not
committed configuration). Once Drupal can talk to your DAM account, run the import
this module provides. See the [overview](../index.md) for the workflow.
