# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
  See the compatibility warning below about Drupal 11.4+.
- **Search API** (`search_api`) — the contrib module this one extends. You need a
  working Search API setup with an index whose datasource is an entity type.
- Core's **Layout Builder** (`layout_builder`) enabled, and content that is
  actually built with Layout Builder.
- Core's **Language** (`language`) module — the processor is language‑aware.

Drupal enables the core dependencies automatically; install Search API yourself
if it isn't already present (`composer require drupal/search_api`).

There are no third‑party Composer or PHP library requirements for this module
itself.

> **Compatibility warning (Drupal 11.4+).** Version 1.0.3 is broken on current
> core: the processor class declares an untyped property that clashes with a
> typed property now declared by core's `LayoutEntityHelperTrait`, causing a PHP
> fatal error whenever Search API instantiates the processor. Until a patched
> release is available, you will not be able to enable or configure the processor
> on Drupal 11.4 or newer.

## Install with Composer

From the project root:

```bash
composer require drupal/layoutbuilder_search_api -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/layoutbuilder_search_api -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en layoutbuilder_search_api -y
```

Enabling the module makes the *Layout builder references* processor available on
your Search API indexes. All the actual configuration happens on the index
itself — see [How to use it](../index.md#how-to-use-it) on the overview page.
