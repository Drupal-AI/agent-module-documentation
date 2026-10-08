# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Views** module (used as the data source for the child field) — this ships
  with Drupal core.
- No external Composer or JavaScript library dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/dynamic_reference_selection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/dynamic_reference_selection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dynamic_reference_selection -y
```

## Verify it worked

There's no admin page to check. Instead, edit an entity‑reference field's settings
(*Manage fields → (a reference field) → field settings*) and confirm that
**Dynamic Reference Selection** now appears in the **Reference method** list. From
there, follow the "How to use it" steps in the [overview](../index.md) to wire up a
parent/child pair.
