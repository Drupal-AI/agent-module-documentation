# Installation

## Requirements

- **Drupal 11.3 or newer** (`core_version_requirement: ^11.3`). This 5.0.x branch
  targets modern Drupal only — for older sites use an earlier Double field
  release.
- **PHP 8.3 or newer**.
- No module dependencies beyond Drupal core (it uses core's Field API, which is
  always available). To use the field's widget and formatters you'll work on the
  standard **Manage fields / form display / display** screens; to import with
  Feeds you'd add the separate [Feeds](https://www.drupal.org/project/feeds)
  module.

There are no third‑party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/double_field -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/double_field -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en double_field -y
```

Or enable **Double field** on the **Extend** page (`/admin/modules`).

There's nothing to configure globally — once enabled, the Double field type is
available wherever you add a field. See
[How to use it](../index.md#how-to-use-it) for the field‑by‑field workflow.

Double field has no submodules.
