# Installation

## Requirements

- **Drupal 11** (`core_version_requirement: ^11`).
- Core **Field** (`field`), **Field UI** (`field_ui`), and **User** (`user`)
  modules — these are the only dependencies of Entity Builder Core, and Drupal
  enables them automatically as dependencies.
- **Optional but recommended:** the **Entity Builder AG-Grid** extension for the
  full spreadsheet editing experience — it requires the AG-Grid JavaScript library
  via Asset Packagist.
- **Optional extensions:** Entity Builder Field Group (needs Field Group), Entity
  Builder Pathauto (needs Pathauto), and Entity Builder Auto Entity Label (needs
  Auto Entity Label) — each is a separate Drupal project.

> **Note:** this release is an early **1.0.0‑alpha1**. Try it on a development
> site before relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/eb -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/eb -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core engine, and — unless you only want YAML/Drush import — the
included UI sub-module:

```bash
drush en eb eb_ui -y
```

- **`eb`** (Entity Builder Core) — the processing engine and YAML import.
- **`eb_ui`** — the browser-based definition management interface and shared API
  endpoints.

For the best editing experience, additionally install and enable the **Entity
Builder AG-Grid** extension (a separate project) once its AG-Grid library
dependency is in place.

## Verify it worked

With `eb_ui` enabled, open the Entity Builder definition management interface in
the admin area. If it loads, the module is installed. Create a small test
definition (a single bundle with one field), preview it, and apply it — then check
**Structure** to confirm the bundle and field were created. See "How to use it" in
the [overview](../index.md) for the full workflow.
