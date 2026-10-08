# Installation

## Requirements

Views Bootstrap Table depends only on core Views:

- **Drupal 9, 10, 11, or 12** (`core_version_requirement: ^9 || ^10 || ^11 || ^12`).
- Core's **Views** module (`views`) enabled — the only dependency, and enabled
  automatically as a dependency when you turn on Bootstrap Table.

The bootstrap-table JavaScript and CSS (version 1.27.0) are **not bundled**. They
load as external assets from `cdn.jsdelivr.net`, so no Composer library is
required, but the site does need to reach that CDN in the browser.

## Install with Composer

From the project root:

```bash
composer require drupal/bootstrap_table -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from
> your host machine — `ddev composer require drupal/bootstrap_table -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en bootstrap_table -y
```

Then edit any view and pick **Bootstrap Table** as its Format — see the "How to
use it" section of the [overview](../index.md).

## Self-hosting the library (optional)

Because the bootstrap-table assets load from a CDN, sites with a strict
content-security policy or an offline/air-gapped requirement will want to
self-host them. The library definitions live in `bootstrap_table.libraries.yml`;
override them in your own theme or module to point at local copies of the
bootstrap-table files.

There are no submodules.
