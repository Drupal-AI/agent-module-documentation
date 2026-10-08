# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- **PHP 8.1 or newer** (`php: >=8.1`).
- Core's **Navigation** module (`navigation`) enabled — this is the only dependency,
  and Drupal enables it automatically as a dependency when you turn on Navigation
  Extra Tools. (The Navigation toolbar is the modern replacement for the classic
  admin Toolbar; this module has no effect without it.)

There are no third‑party Composer or PHP library requirements. **Devel** and
**Project Browser** are supported if present but are not required.

## Install with Composer

From the project root:

```bash
composer require drupal/navigation_extra_tools -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/navigation_extra_tools -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en navigation_extra_tools -y
```

After enabling, the Tools items are hidden until you grant the relevant permissions —
see [How to use it](../index.md#how-to-use-it) for which permissions reveal the
cache‑flush and cron shortcuts.

There are no submodules.
