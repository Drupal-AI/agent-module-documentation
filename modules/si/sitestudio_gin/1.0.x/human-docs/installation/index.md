# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- **Acquia Site Studio / Cohesion** — the `cohesion` module (Composer package
  `acquia/cohesion`, `^6.7.0 || ^7 || ^8`). It is a declared dependency.
- **The Gin admin theme** — Composer package `drupal/gin` (`^3.0 || ^4.0 || ^5`),
  installed and available. The module runs an install‑time requirements check
  (borrowed from Gin Toolbar) and **blocks installation if the Gin theme is not
  present**, so make sure Gin is installed first.

## Install with Composer

From the project root:

```bash
composer require drupal/sitestudio_gin -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update the
shared dependencies (Cohesion, Gin) as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/sitestudio_gin -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Make sure the Gin theme is installed and set as your administration theme, then:

```bash
drush en sitestudio_gin -y
```

Once enabled with Gin active, the integration works immediately — there is no
configuration step. If Site Studio and Gin are not both present the module can
still enable, but its overrides only take effect when both are in use, which is
expected for an optional integration.

## Submodules

None — Site Studio Gin ships as a single module.
