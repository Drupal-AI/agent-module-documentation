# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No module dependencies, and no third-party Composer or PHP libraries. It builds on
  core's Field and Field UI.
- **Optional:** the **Inline Entity Form** module
  (`drupal/inline_entity_form`). When present, the module adds a cardinality-aware
  Inline Entity Form (simple) widget.

## Install with Composer

From the project root:

```bash
composer require drupal/field_config_cardinality -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/field_config_cardinality -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en field_config_cardinality -y
```

There is no configuration page and no permission to grant. Once enabled, the **"Allowed
number of values (Cardinality Instance)"** fieldset appears on every field instance's
edit form.

## Verify it worked

Edit any field instance — for example **Structure → Content types → (type) → Manage
fields → (your field) → Edit** — and look for the **Allowed number of values
(Cardinality Instance)** fieldset. See the [Configuration](../configuration/index.md)
guide to set a per-bundle limit.
