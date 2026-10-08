# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- These core modules, which Drupal enables as dependencies: **Media** (`media`),
  **Media Library** (`media_library`), **Field** (`field`), **Block** (`block`),
  and **CKEditor 5** (`ckeditor5`).
- A **JW Player account** with a **JW Player API v2 key** and a **JW Player site
  ID** — you'll enter both after installation.

## Install with Composer

From the project root:

```bash
composer require drupal/jw_player_media_source -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/jw_player_media_source -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en jw_player_media_source -y
```

Or enable **JW Platform Media Source** on the **Extend** page (`/admin/modules`).

## Verify it worked

Go to **Configuration → Media → JW Platform Media Source**
(`/admin/config/media/jw-player-media-source`). If the settings form loads, the
module is installed. Enter your credentials there (see
[Configuration](../configuration/index.md)), then visit **Content → JW media**
(`/admin/content/jw-media`) — with valid credentials the remote JW library listing
should render.

> **Heads up:** This release is not covered by Drupal's security advisory policy.
