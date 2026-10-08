# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2||^11`).

There are no other module dependencies and no third‑party Composer or PHP library
requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/importmap -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/importmap -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en importmap -y
```

## Verify it worked

Add a `data-importmap-name` attribute to a library's JS in a `*.libraries.yml` file
(see the module's index page for an example), rebuild caches, and load a page that
uses that library. View the page source and confirm a `<script type="importmap">`
block appears with your mapped entry. Then confirm a bare‑specifier `import` in your
module code resolves in the browser.
