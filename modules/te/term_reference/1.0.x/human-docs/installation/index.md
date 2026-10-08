# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Field** (`field`) and **Taxonomy** (`taxonomy`) modules, enabled
  automatically as dependencies.

There are no third‑party Composer or PHP library requirements. The module adds no
permission of its own — access is derived from term‑update and field‑edit access
(see the [main guide](../index.md)).

## Install with Composer

From the project root:

```bash
composer require drupal/term_reference -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/term_reference`)
matches the module's machine name (`term_reference`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_reference -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_reference -y
```

## Verify it worked

Make sure some content type has a taxonomy‑term reference field, then visit one of
that vocabulary's term pages (for example `/taxonomy/term/1`). You should see a new
**References** tab. There is no configuration to complete — the tab appears
wherever eligible reference fields exist.
