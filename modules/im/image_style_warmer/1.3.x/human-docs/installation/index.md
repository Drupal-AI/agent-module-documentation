# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Image** module (`image`), part of a standard Drupal install and enabled
  automatically as a dependency.
- No third-party Composer packages or PHP library requirements.
- You'll want **cron** running for the "Queue image styles" list to be processed in the
  background.

## Install with Composer

From the project root:

```bash
composer require drupal/image_style_warmer -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/image_style_warmer -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en image_style_warmer -y
```

Once enabled, nothing is warmed until you choose which image styles to generate — the
two style lists both start empty. Head to [Configuration](../configuration/index.md) to
pick them.
