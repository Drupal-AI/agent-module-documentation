# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).

There are no third‑party Composer or PHP library requirements, and no module
dependencies. This branch is `8.x-1.x`; it is security-advisory covered.

## Install with Composer

From the project root:

```bash
composer require drupal/classitup -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/classitup -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en classitup -y
```

That is the whole setup — there is no settings form. If a theme you build declares
Class It Up as a dependency, enabling that theme will pull the module in as well.

## Verify it worked

Load a full node page and inspect the markup in your browser's developer tools. You
should see the extra classes on the `<body>` / page wrapper (such as
`page--content-item` and `page--content-item--[content-type]`), and region and
block-type classes on blocks. Those are the hooks you now style in your theme's CSS.
