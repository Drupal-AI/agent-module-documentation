# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 ||
  ^11`).
- The **FitVids.js** JavaScript library. The module expects the library file at
  `/libraries/fitvids/jquery.fitvids.js` (relative to your web root). Download
  FitVids.js and place it there before configuring the module — otherwise the
  page attachment has nothing to run.

There are no third‑party Composer requirements beyond Drupal core itself.

## Install with Composer

From the project root:

```bash
composer require drupal/fitvids -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/fitvids -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Add the FitVids.js library

Create the `libraries/fitvids/` directory in your web root and put the
`jquery.fitvids.js` file inside it, so the final path is
`/libraries/fitvids/jquery.fitvids.js`. Without this file the module loads but
does nothing.

## Enable the module

```bash
drush en fitvids -y
```

There are no submodules. Once enabled, configure it at **Configuration → Media →
FitVids** (requires the **Administer FitVids** permission) — see the
[overview](../index.md) for the three settings.
