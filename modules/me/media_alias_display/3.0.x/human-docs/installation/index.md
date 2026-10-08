# Installation

## Requirements

Media Alias Display needs:

- **Drupal 11.3+ or 12** (`core_version_requirement: ^11.3 || ^12`, and it
  explicitly requires `drupal/core: ^11.3 || ^12`).
- Core's **Media Library** module (`media_library`), which Drupal enables
  automatically as a dependency.
- Core Media's **Standalone media URL** setting turned **on** — this is what gives
  a media entity a canonical URL for the module to take over. Without it the
  module has nothing to override and the status report shows a warning.

There are no third-party Composer packages, PHP extensions, or JavaScript
libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/media_alias_display -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_alias_display -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_alias_display -y
```

## Turn on Standalone media URL

This is required. Enable it at **Configuration → Media → Media settings**
(`/admin/config/media/media-settings`) by ticking **Standalone media URL**, or
from the command line:

```bash
drush cset media.settings standalone_url true -y
```

If you skip this step, media entities have no canonical URL to serve files from,
and the module's status-report check will warn you.

## Submodule — Media Alias Display Field Override

The optional submodule **Media Alias Display Field Override**
(`media_alias_display_field_override`) adds a per-media checkbox so you can exclude
individual media items from the direct-file behavior. Enable it only if you need
that opt-out control:

```bash
drush en media_alias_display_field_override -y
```

It requires the base Media Alias Display module, which is already present once you
have installed it above.

## Verify it worked

Confirm the settings form loads at **Configuration → Media → Media Alias Display**
(`/admin/config/media/media_alias_display`). Then create a file-based media entity,
give it a path alias, and visit that alias — the file should open directly rather
than showing the media page. See [Configuration](../configuration/index.md) to
restrict which bundles are affected or to use the kill switch.
