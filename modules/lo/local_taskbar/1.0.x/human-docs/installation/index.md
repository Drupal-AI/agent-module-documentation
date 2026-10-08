# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No other modules or third‑party libraries are required — the module has no
  dependencies.

This is a **1.0.0-alpha2** release, so test it on a non‑production environment
first.

## Install with Composer

From the project root:

```bash
composer require drupal/local_taskbar -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/local_taskbar -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en local_taskbar -y
```

## Verify it worked

Visit a page that shows local tasks (for example a node's edit page). The tabs
should now render through Local Taskbar's template rather than the default core
markup. If you do not see a tabs block at all, place the "Tabs" block in a region
at **Structure → Block layout**. To customise the appearance, override
`block--local-tasks-block.html.twig` in your theme — see
[How to use it](../index.md#how-to-use-it).
