# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- The **Charts** module (`charts:charts`), installed and configured.
- Core's **Views** module (part of Drupal core) — the chart must be built as a
  View.
- No third‑party PHP or JavaScript libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_exposed_settings -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Charts
dependency and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_exposed_settings -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_exposed_settings -y
```

## Verify it worked

Open a chart View in the **Views UI** and add a field or filter. The list should
now include the exposed chart handlers — title, subtitle, X‑axis title, and
Y‑axis title. Add one, expose it, and confirm that entering a value on the
rendered page updates the corresponding label on the chart.
