# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- Core's **File** module (`file`) — enabled automatically as a dependency.
- **The MediaElement.js player library.** This is important: by default the module loads the
  library from a self‑hosted copy at `/libraries/mediaelement/build`. You have two options:
  - **Self‑host (default):** download MediaElement.js and place its `build` folder at
    `web/libraries/mediaelement/build` (so files resolve under
    `/libraries/mediaelement/build/…`).
  - **Use the CDN:** skip the download and instead switch the *Library source* to **CDNJS** on
    the settings form after enabling (see [Configuration](../configuration/index.md)).

  Until one of these is in place, the formatters render the media tags but the player does not
  initialize.

There are no PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/mediaelement -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies as
needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host machine —
> `ddev composer require drupal/mediaelement -W`, `ddev drush …`. Inside the container
> (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en mediaelement -y
```

There are no submodules. After enabling, visit the settings form to confirm (or change) the
library source, then set the formatter on your file fields — see
[Configuration](../configuration/index.md).
