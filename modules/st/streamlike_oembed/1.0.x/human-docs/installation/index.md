# Installation

## Requirements

- **Drupal 9 or 10** (`core_version_requirement: ^9 || ^10`).
- No other modules are required. It pairs well with the **Streamlike Media**
  module — whose field can hold the media ID this module reads — but that is
  optional.
- No third-party Composer or PHP library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/streamlike_oembed -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/streamlike_oembed -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en streamlike_oembed -y
```

## Verify it worked

After enabling, open the settings form at
`/admin/config/media/streamlike-oembed` and add at least one route-to-field
mapping (see [Configuration](../configuration/index.md)). Then load a canonical
page for a matching route — for example a node that has the mapped field filled in
with a valid 16-character Streamlike media ID — and confirm the oEmbed discovery
tags for the Streamlike player are present in the page.
