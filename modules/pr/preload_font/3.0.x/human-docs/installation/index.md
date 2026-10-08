# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no dependent
modules.

## Install with Composer

From the project root:

```bash
composer require drupal/preload_font -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/preload_font -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en preload_font -y
```

## Verify it worked

After enabling, add one or more font files on the settings page — see
[Configuration](../configuration/index.md). Then load a front-end page and view its
source (or use your browser's Network tab): you should see a
`<link rel="preload" as="font" crossorigin …>` tag in the `<head>` for each font
you configured, and the font file requested near the start of the load rather than
after the CSS.
