# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`).
- Core's **Views** module (enabled by default on most sites) — FooTable is a Views
  table style.
- **The FooTable jQuery library**, downloaded separately (see below). The module
  provides only the Drupal integration; it does not bundle the plugin's JS/CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/footable -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/footable -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Add the FooTable jQuery library

The module expects the FooTable 3.x plugin to live in `libraries/footable/`, so
that `libraries/footable/compiled/footable.min.js` (and the matching CSS) exists.

- Download the 3.x release from
  [github.com/fooplugins/FooTable](https://github.com/fooplugins/FooTable) and
  unpack it into `libraries/footable/`, **or**
- add it as a Composer package (`fooplugins/footable`) via a custom package
  repository, as described in the module's README.

Notes:

- The **Bootstrap** variant additionally needs your theme to provide Bootstrap CSS.
- The **Standalone** variant needs Font Awesome for its expand/collapse icons.

## Enable the module

```bash
drush en footable -y
```

## Verify and configure

1. Grant the **Administer FooTable** permission to your admin role under **People →
   Permissions** if it is not already granted.
2. Visit **Configuration → User interface → FooTable → Settings** and confirm the
   plugin variant/compression match the library build you installed.
3. Edit a table view, set its **Format** to **FooTable**, and configure the
   responsive/filtering/paging options.

See the [main page](../index.md#how-to-use-it) for the full walkthrough of the
global settings, breakpoints, and per-view options.
