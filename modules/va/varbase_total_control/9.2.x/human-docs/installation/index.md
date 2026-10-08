# Installation

## Requirements

- **Drupal 11.4** (`core_version_requirement: ~11.4.0`).
- The **Total Control** module (`drupal/total_control` ~3) — provides the *Have
  total control* permission and the base dashboard machinery. Enabled
  automatically as a dependency.
- The **Charts** module (`drupal/charts` ~5) plus its **C3** sub‑module
  (`charts_c3`) — pulled in by Composer for the dashboard's chart widgets.
- **Panels / Page Manager** — the dashboard is a Page Manager page.
- `vardot/module-installer-factory` (~1) — a Composer helper used during install.

## Install with Composer

From the project root:

```bash
composer require drupal/varbase_total_control -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Total Control,
Charts, and the other dependencies along with any shared packages.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/varbase_total_control -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en varbase_total_control -y
```

This also enables the `total_control` dependency (and the Charts modules) if they
aren't already on.

## Apply the recipe (optional but recommended)

The module ships a recipe at `recipes/default` that grants the **Have total
control** permission to the `editor`, `content_admin`, `seo_admin`, and
`site_admin` roles, and enables supporting configuration. Applying it saves you
from wiring up dashboard access by hand. If you prefer, you can instead grant the
permission manually — see [Configuration](../configuration/index.md).

## Next steps

Head to [Configuration](../configuration/index.md) to grant dashboard access and
customize the widgets.
