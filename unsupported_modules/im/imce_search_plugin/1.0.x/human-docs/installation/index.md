# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **PHP 8.1 or newer** (`php_requirement: ^8.1`).
- The **IMCE** module at version **^3.0** (`imce ^3.0`) — the file browser this
  plugin extends. Install and enable it first, or let Composer pull it in.

This release is **1.0.0‑beta2** (a beta); test it against your file volume before
relying on it in production.

## Install with Composer

The project's machine name on drupal.org is **`imce_search_2`**, so that is the
name Composer expects:

```bash
composer require drupal/imce_search_2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/imce_search_2 -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

**Heads up — the project name and the module name differ.** The project is
`imce_search_2`, but the module it ships is **`imce_search_plugin`**. Running
`drush en imce_search_2` will fail. Enable it by the module name:

```bash
drush en imce_search_plugin -y
```

Drupal will enable IMCE automatically if it is not already on.

## Verify it worked

Open an IMCE file browser (for example from an image field or the CKEditor image
dialog) as a user whose IMCE profile grants some folders. A search box should now
appear inside the browser. Type part of a filename and confirm that matching
results show up with previews.
