# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`), enabled automatically as a dependency. You'll
  also need a **Link** field to apply the formatter to (core's Link module provides
  that field type).
- A theme that loads **Bootstrap** (or equivalent `.btn` CSS) — the module emits the
  button classes but ships no CSS of its own.

There are no third‑party Composer libraries, no settings page, and no permissions.

## Install with Composer

From the project root:

```bash
composer require drupal/button_link -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/button_link -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en button_link -y
```

There are no submodules. Once enabled, the **Link as Button** formatter becomes
available for any Link field on the *Manage display* page — see
[How to use it](../index.md#how-to-use-it).
