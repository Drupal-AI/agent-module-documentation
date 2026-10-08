# Installation

## Requirements

- **Drupal 10.3 or 11** (`core_version_requirement: ^10.3 || ^11`).
- Core's **Media** module (`media`) enabled — this is the only dependency, and
  Drupal enables it automatically as a dependency when you turn on Media Embed
  Extra.
- A text format with the core **Embed media** filter, used with a WYSIWYG editor
  (CKeditor 5). This is how editors embed media in the first place.

There are no third-party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/media_embed_extra -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/media_embed_extra -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en media_embed_extra -y
```

There are no submodules. After enabling, make sure the text format your editors
use has the **Embed media** filter turned on (and, if you limit allowed HTML, that
the `data-width` and `data-height` attributes are allowed on `<drupal-media>`) —
see the [main page](../index.md) for that one-time setup. Once that's in place, the
Dimensions fields appear automatically in the media embed dialog for image media.
