# Installation

## Requirements

- **Drupal 9.5, 10, or 11** (`core_version_requirement: ^9.5 || ^10 || ^11`).
- Core modules **File, Image, Media, Media Library, and Views** — Drupal enables
  these as dependencies.
- Two contributed modules, pulled in by Composer: **Token** (`drupal/token ^1.10`)
  and **Views Remote Data** (`drupal/views_remote_data ^1.0.1`).
- The **guzzlehttp/psr7** library (`^1.0 || ^2.0`), also handled by Composer.
- A working **Acquia DAM (Widen)** account and OAuth credentials (domain, client
  id, client secret). Without these the module installs and its Drupal-side config
  is inspectable, but no real asset operations will work.
- Recommended: the **Key** module, so you can store the DAM client secret in a Key
  entity instead of plain configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/acquia_dam -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
(Token, Views Remote Data, guzzlehttp/psr7) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/acquia_dam -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en acquia_dam -y
```

Drupal enables the core and contributed dependencies at the same time. On install
the eight media types (Image, Video, Audio, PDF, Documents, Archive, SpinSet,
Generic) and the DAM asset library view are created for you. The site is **not yet
connected** to any DAM — that happens in [Configuration](../configuration/index.md).

## Submodules — enable only what you need

Acquia DAM ships two optional submodules. Enable them individually once the base
module is connected:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Integration Links** | `acquia_dam_integration_links` | Deep discovery of where assets are used across the site — entity references, paragraphs, and embeds inside WYSIWYG text — and registers that usage back to the DAM. |
| **Asset Import** | `acquiadam_asset_import` | Bulk-imports assets into Drupal media entities by Widen category or asset group, with its own Drush import commands. |

```bash
drush en acquia_dam_integration_links -y
drush en acquiadam_asset_import -y
```

## Verify it worked

Visit **Configuration → Acquia DAM** (`/admin/config/acquia-dam`). You should see
the connection form asking for your DAM domain and OAuth details. Continue with
[Configuration](../configuration/index.md) to connect the site and authorize your
DAM account.
