# Installation

## Requirements

- **Drupal 10.5 or 11.2** (`core_version_requirement: ^10.5 || ^11.2`). This range is
  deliberately narrow — it targets recent minor releases only, so check your core
  version before installing.
- The **Fluid Infusion** front‑end library (the Fluid UI Options framework source
  files). This is a third‑party JavaScript library that the module integrates but does
  not itself bundle; you add it separately (see below).

The module has no other Drupal module dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/fluidui -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/fluidui -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the Fluid Infusion library

Fluid UI relies on the Fluid Infusion (UI Options) library. Obtain the framework source
files and place/compile them as the module's `README` describes — the library is built
with the Infusion tooling (Grunt/NPM) rather than shipped ready‑made. Follow the
version and build steps in the module's own README so the compiled library matches the
release you installed.

## Enable the module

```bash
drush en fluidui -y
```

## Verify it worked

Visit a non‑admin (front‑end) page of your site as a regular visitor. The Fluid UI
Options preferences panel should be available, letting you change text size, contrast,
line height, and related settings, with your choices remembered as you move between
pages. If the panel does not appear or the controls have no effect, confirm the Fluid
Infusion library is correctly built and placed, and check the note in
[Configuration](../configuration/index.md) about themes that need extra CSS.
