# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Node** module.
- The **Entity Embed** module (`entity_embed`) — used to embed charts in rich text.
- **External JavaScript libraries** in `/libraries` — Highcharts, the Highcharts
  Editor, the Easychart v3 plugin and Handsontable. These are **not** installed by
  Composer; see "Install the JavaScript libraries" below.
- A **Highcharts licence** for any commercial or government site. Highcharts is free
  for non-commercial use only.

## Install with Composer

From the project root:

```bash
composer require drupal/easychart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed. If Entity Embed is not yet present, add it too:

```bash
composer require drupal/entity_embed drupal/easychart -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/easychart -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en easychart -y
```

Enabling the module installs the ready-made **Chart** content type (with an
Easychart field, its displays, and an Entity Embed button), plus the permissions
and settings.

## Install the JavaScript libraries

The visual editor and chart rendering need external JS libraries that Composer does
**not** manage. After enabling the module, download them with the provided Drush
command:

```bash
drush easychart:install
# or the alias:
drush eci
```

This creates `/libraries` if needed and downloads and extracts the Easychart plugin,
Highcharts and the Highcharts Editor into place. Run it once after enabling the
module (on DDEV: `ddev drush eci`). The command requires the `easychart` module to
be enabled and errors otherwise. You can also place the libraries manually if you
prefer.

Without these libraries the chart editor will not function, so treat this step as
part of installation. Continue to [Configuration](../configuration/index.md) for the
admin defaults, presets, templates and permissions.
