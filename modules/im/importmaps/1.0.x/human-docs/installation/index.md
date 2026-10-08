# Installation

## Requirements

- **Drupal 9.0 or newer** (`core_version_requirement: >=9.0`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements. Note this release is **1.0.0‑alpha2** (an alpha) and the project is
marked **No further development** — see the overlap note on the module's index page
before relying on it.

## Install with Composer

From the project root:

```bash
composer require drupal/importmaps -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/importmaps -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en importmaps -y
```

## Verify it worked

Add a `*.importmaps.yml` file to a module (see the module's index page for an
example), rebuild caches, and load a page. View the page source and confirm a single
`<script type="importmap">` element appears containing your declared entries.
