# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: >=11.0 <12`).
- No third‑party Drupal module or PHP library requirements. To actually run the
  tests you will need **Cypress** and/or **Playwright** installed in your project's
  Node.js toolchain (outside Drupal).
- Install this in a **development or CI** environment only — not on production.

## Install with Composer

From the project root:

```bash
composer require drupal/automated_testing_kit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. Consider requiring it as a dev dependency
(`composer require --dev …`) so it never ships to production.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/automated_testing_kit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en automated_testing_kit -y
```

This provides the reusable tests, helper functions, and Drush commands.

## Optional: the demo submodule

The kit ships a demo submodule with worked examples you can learn from or copy:

```bash
drush en automated_testing_kit_demo -y
```

Enable it only in a test environment — like the main module, keep it out of
production.
