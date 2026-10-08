# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- Core's **User** module (`user`), which Drupal enables as a dependency.

There are no third-party Composer or PHP library requirements — the Link Purpose
JavaScript library is bundled with the module.

## Install with Composer

From the project root:

```bash
composer require drupal/linkpurpose -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/linkpurpose -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en linkpurpose -y
```

Once enabled, the icons and screen-reader hints appear on non-admin pages
immediately, with every link purpose turned on. To fine-tune which purposes are
marked, their wording, icons, and which regions are scanned, see the *How to use
it* section on the [overview page](../index.md) — the settings live at
**Configuration → User interface → Link Purpose Icons**.
