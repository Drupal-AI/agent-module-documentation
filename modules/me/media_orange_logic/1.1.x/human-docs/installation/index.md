# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **Media** module enabled.
- The **`drupal/media_library_extend`** module, which this module requires, plus
  **several patches** — see the module's own README for the exact patch list and
  how to apply them (typically via `cweagans/composer-patches` in your project's
  `composer.json`).
- An **Orange Logic (Cortex) DAM** account with API access, and outbound HTTPS
  connectivity from your Drupal environment to the DAM's API endpoints.

There are no PHP library requirements beyond the above.

## Install with Composer

From the project root:

```bash
composer require drupal/media_orange_logic -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies — including `drupal/media_library_extend` — as needed. Before
installing, set up the patches the module's README lists, since the integration
depends on them.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_orange_logic -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_orange_logic -y
```

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Media Orange Logic Samples** | `media_orange_logic_samples` | Ready‑made example audio/video media types and a sample entity browser (`orangelogicmediabrowser`) so you can see a working configuration quickly. |
| **Orange Logic Media Library** | `orange_logic_media_library` | Adds an Orange Logic source to the Media Library. Currently only **image** media is supported through this path. |

Enable them individually, for example:

```bash
drush en media_orange_logic_samples -y
```

## Verify it worked

Log in as an administrator and visit **Configuration → Media → Media Orange Logic**
(`/admin/config/media/media-orange-logic`). If the credential form loads, the
module is installed. Continue to [Configuration](../configuration/index.md) to
enter your DAM endpoints and credentials — searching the DAM won't work until
those are set.
