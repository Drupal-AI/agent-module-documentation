# Installation

## Requirements

- **Drupal 11.2 or 12** (`core_version_requirement: ^11.2 || ^12`).
- **PHP 8.3** or newer.
- The **Drupal Canvas** module (`canvas`) — required; this module extends Canvas
  and cannot work without it.

There are no additional third-party Composer library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/canvas_field_component -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Drupal Canvas is not already installed, require it as
well (`composer require drupal/canvas -W`).

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/canvas_field_component -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en canvas_field_component -y
```

## Verify it worked

Open a template in the Canvas editor and open the component library — you should
now find a **Field Display** component you can drag into the template. The
[Configuration](../configuration/index.md) page walks through selecting a field and
formatter.
