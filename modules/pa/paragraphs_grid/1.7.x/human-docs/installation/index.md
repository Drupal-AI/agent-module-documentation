# Installation

## Requirements

Paragraphs Grid extends the Paragraphs module:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The contributed **Paragraphs** module (`drupal/paragraphs`) — a hard dependency
  that Composer installs for you.

There are no other third‑party Composer or PHP library requirements. The module
ships its own Bootstrap and Material Design Components grid CSS, so you do not need
to add a framework yourself unless you prefer to use your theme's own grid CSS.

## Install with Composer

From the project root:

```bash
composer require drupal/paragraphs_grid -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Paragraphs and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/paragraphs_grid -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en paragraphs_grid -y
```

Drupal enables the base **Paragraphs** module as a dependency automatically. There
are no submodules.

## Permissions

Paragraphs Grid adds a **Use Paragraphs Grid config form** permission, which is
**restricted** — switching the active grid framework can change stored grid classes,
so grant it only to trusted administrators. Assign it at **People → Permissions**.

## Verify it worked

Go to **Configuration → Content authoring → Paragraphs Grid**
(`/admin/config/content/paragraphs_grid`). You should see the settings form with a
grid‑type selector (Bootstrap 3/4/5 or MDC). Next, see
[Configuration](../configuration/index.md) to pick a grid system and add the grid
field to a paragraph type.
