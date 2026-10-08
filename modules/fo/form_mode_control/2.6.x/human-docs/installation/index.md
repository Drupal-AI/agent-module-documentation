# Installation

## Requirements

Form Mode Control builds on core's Field UI. It needs:

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) enabled — this is its only dependency, and it
  is on by default in a standard Drupal install. You'll also want Field UI enabled
  so you can build form modes and form displays.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/form_mode_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/form_mode_control -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en form_mode_control -y
```

Enabling the module has no visible effect on its own — you need at least one
alternate form mode to control. Head to
[Configuration](../configuration/index.md) to build a form mode, set the per‑role
defaults, and grant the form‑mode permissions.
