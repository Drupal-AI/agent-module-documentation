# Installation

## Requirements

- **Drupal 9.1, 10, or 11** (`core_version_requirement: ^9.1 || ^10 || ^11`).
- Core's Taxonomy and Field systems, which are part of standard Drupal. The module
  declares no additional module dependencies.

There are no third‑party Composer or PHP library requirements, and the module
provides no permissions of its own.

## Install with Composer

From the project root:

```bash
composer require drupal/term_level -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. The Composer package name (`drupal/term_level`) matches
the module's machine name (`term_level`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/term_level -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en term_level -y
```

## Verify it worked

Go to any content type's **Manage fields** page
(**Structure → Content types → *(your type)* → Manage fields**) and add a new
field. **Term Level** should appear as an available field type. See the
[main guide](../index.md) for how to configure the vocabulary and levels once the
field is added.
