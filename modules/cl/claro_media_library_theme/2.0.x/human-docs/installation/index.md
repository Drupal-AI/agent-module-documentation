# Installation

## Requirements

- **Drupal 11.4** specifically (`core_version_requirement: ^11.4`). This is an
  exceptionally narrow requirement that pins the module to a single core minor, so
  check compatibility again every time you update core.
- Core's **Media Library** module (`media_library`) enabled — this is the only
  dependency, and Drupal will enable it automatically when you turn on this module.

There are no third‑party Composer or PHP library requirements. Note that this is a
**beta** release (`2.0.0-beta1`).

## Install with Composer

From the project root:

```bash
composer require drupal/claro_media_library_theme -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/claro_media_library_theme -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en claro_media_library_theme -y
```

That is the whole setup. There is no configuration and no permissions to grant.

## Verify it worked

Open the media library from a front-end context where it used to look broken — for
example a Layout Builder off-canvas dialog, an inline entity form on a public page,
or a front-end editing interface. The library should now render as its proper
styled grid instead of an unstyled list. If the library already looked fine
everywhere on your site, you probably did not need this module.
