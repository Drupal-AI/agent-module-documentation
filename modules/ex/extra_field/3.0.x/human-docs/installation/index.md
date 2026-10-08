# Installation

## Requirements

- **Drupal 10.2 or 11** (`core_version_requirement: ^10.2 || ^11`).
- Core's **Field** module (`field`) enabled — this is the only dependency and it is
  part of every standard install.

There are no third‑party Composer or PHP library requirements. The module provides
Drush code generators for scaffolding plugins, so a working Drush is handy for
development but not required to run the module.

## Install with Composer

From the project root:

```bash
composer require drupal/extra_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/extra_field -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en extra_field -y
```

Enabling the base module registers the two plugin types (display and form) but adds
no fields on its own — extra fields appear only once a module provides a plugin.

## Optional: the example submodule

To see working extra fields immediately and get copy‑ready plugin templates, enable
the bundled **Extra Field Example** submodule:

```bash
drush en extra_field_example -y
```

Its plugins then show up on the relevant entities' *Manage display* / *Manage form
display* pages, and its source is the fastest starting point for writing your own.

## Verify it worked

With the example submodule enabled, go to a content type's **Manage display**
(*Structure → Content types → Article → Manage display*). You should see one or more
example extra fields listed among the disabled/available fields — drag one into a
region, save, and view a node of that type to see it render.

For how to write your own display and form plugins, see the
[`agent/`](../agent/start.md) reference.
