# Installation

## Requirements

Entity Type Behaviors is lightweight and has no contrib dependencies:

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement: ^8.8 || ^9 || ^10 || ^11`).
- **PHP 7.1 or newer**.

There are no required third-party Composer or PHP libraries. The module provides
config schema and an `entity_type_behavior` plugin type, but nothing you must set
up before it runs.

Optional: the module *suggests* [GraphQL Compose](https://www.drupal.org/project/graphql_compose)
if you want behaviors exposed in your GraphQL schema. Install it only if you need
that integration.

## Install with Composer

From the project root:

```bash
composer require drupal/entity_type_behaviors -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_type_behaviors -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_type_behaviors -y
```

There is no configuration step and no settings page — the framework is ready to
use as soon as it is enabled. Behaviors are turned on from each bundle's edit form,
and the values widget is placed via *Manage form display* (see the
[overview](../index.md#where-it-lives-in-the-admin-menu)).

## The example submodule

The project ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Entity Type Behaviors Example** | `entity_type_behaviors_example` | A working example behavior (including a config form that restricts the color options an editor may choose). Enable it to see the framework in action and use it as a template for your own plugins. |

```bash
drush en entity_type_behaviors_example -y
```

It requires the base module, which is already present once you have installed the
project above. Disable it again on production once you have finished learning from
it.
