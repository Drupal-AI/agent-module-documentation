# Installation

## Requirements

- **Drupal 10.2+, 11, or 12** (`core_version_requirement: ^10.2||^11||^12`).
- The **Convivial Core** module (`convivial_core`) — Convivial Profiler depends on
  it, and Composer/Drupal will bring it in as a dependency.

There are no additional third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/convivial_profiler -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Convivial Core and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convivial_profiler -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convivial_profiler -y
```

This also enables **Convivial Core** if it is not already on.

## Verify it worked

Go to **Configuration → Convivial → Profiler**
(`/admin/config/convivial/profiler`). If you can open the profiler settings form,
the module is installed. It does nothing until you configure it — continue to
[Configuration](../configuration/index.md), and be sure your consent handling is
in place before you profile real visitors.
