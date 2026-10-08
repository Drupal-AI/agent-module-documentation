<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Installation

## Requirements

- **Drupal 8, 9 or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- No other modules and no third-party PHP libraries are required.
- **A note on the Redoc library:** the rendering library
  (`redoc.standalone.js`) is loaded from the **jsDelivr CDN** as an external
  script. If your site is offline/air-gapped or enforces a strict Content Security
  Policy, that external script will be blocked — you would need to allow the CDN
  host, or host the script yourself, for the docs to render.

## Install with Composer

From the project root:

```bash
composer require drupal/api_redoc_document -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/api_redoc_document -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en api_redoc_document -y
```

Then clear caches so the library attaches:

```bash
drush cr
```

## Allow the `<redoc>` tag

There is no admin settings form. The only setup step is making sure the text format
you use on the field where you embed a spec allows the `<redoc>` tag — **Full
HTML** allows it, or configure a filtered format so the tag is not stripped. Then
embed `<redoc spec-url="…"></redoc>` as described in the [main guide](../index.md).
