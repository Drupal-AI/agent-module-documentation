# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Taxonomy** (`taxonomy`) module, enabled automatically as a dependency.

There are no third‑party Composer or PHP library requirements, and the module
provides no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/term_entity_condition -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name
(`drupal/term_entity_condition`) matches the module's machine name
(`term_entity_condition`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_entity_condition -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_entity_condition -y
```

## Verify it worked

Edit any block under **Structure → Block layout**
(`/admin/structure/block`). Among the visibility conditions you should now see a
new **taxonomy term** condition. See the [main guide](../index.md) for how to use
it. There is no global configuration to complete.
