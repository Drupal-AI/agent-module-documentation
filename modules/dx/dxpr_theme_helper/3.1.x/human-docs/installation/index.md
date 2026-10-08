# Installation

## Requirements

- **Drupal 9.3, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- Core modules **Node**, **Text**, **Media**, **Media Library**, and **Media Library
  Form Element**, which Drupal enables automatically as dependencies.
- **DXPR Theme** installed — this is a companion module. The `dxt:config:*` and
  `dxt:palette:*` commands read and write a DXPR Theme (or subtheme) settings object,
  so a DXPR Theme must be present for them to have something to target. (The
  `dxt:config:list` command works without one, reading the bundled schema.)

Optional:

- **`drupal/ai`** (`^1`), configured with a chat provider — required only for the AI
  color-palette and font generators (`dxt:generate:*`). Without it, those commands
  report that the AI module is not installed.

## Install with Composer

Note the vendor namespace is `dxpr/`, not `drupal/`:

```bash
composer require dxpr/dxpr_theme_helper -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run them from your
> host machine — `ddev composer require dxpr/dxpr_theme_helper -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en dxpr_theme_helper -y
```

## Optional: enable the AI generators

To use `dxt:generate:palette` / `dxt:generate:fonts`, install and configure the AI
module with a chat provider and default model:

```bash
composer require drupal/ai -W
drush en ai -y
```

Then configure a provider following the AI module's own documentation. The generators
also need DXPR Theme installed, since the palette fields come from the theme's color
settings.

## Permissions

DXPR Theme Helper defines **no permissions of its own**. Its admin routes (including
the AI-generation endpoints) reuse core's **Administer themes** permission, so grant
that to users who need to run these features from the UI.

## Verify it worked

Run a read-only command to confirm the Drush suite is available:

```bash
drush dxt:config:list --sections-only
```

You should see the DXPR Theme settings sections listed. See
[Configuration](../configuration/index.md) for the blocks, fields, and full command
set.
