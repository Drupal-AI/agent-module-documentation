# Installation

## Requirements

Switch Theme is lightweight. It needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9||^10||^11`).
- No other contrib modules and no third-party PHP libraries — it builds only on
  Drupal core's theme system.

## Install with Composer

From the project root:

```bash
composer require drupal/switch_theme -W
```

The Composer package name (`drupal/switch_theme`) matches the module's machine
name (`switch_theme`). The `-W` (`--with-all-dependencies`) flag lets Composer
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/switch_theme -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en switch_theme -y
```

Enabling the module registers the theme negotiator, but nothing changes for
visitors yet — the negotiator only acts once you have defined at least one
role-and-URL rule. Head to [Configuration](../configuration/index.md) to set
those up.
