# Installation

## Requirements

- **Drupal 9.5 through 11** (`core_version_requirement: >=9.5 <12`).
- Core's **Field** module (`field`) — the only dependency, and it's enabled on
  essentially every Drupal site. Drupal enables it automatically if needed.
- To use the display separators and prefixes you don't need anything extra; to use
  the Views handlers you'll want core's **Views** module enabled (it usually is).

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/range -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/range -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en range -y
```

Or enable **Numeric Range** on the **Extend** page (`/admin/modules`).

There's nothing to configure globally — once enabled, the three Range field types
are available wherever you add a field. See [How to use it](../index.md#how-to-use-it)
for the field‑by‑field workflow.

Numeric Range has no submodules.
