# Installation

## Requirements

- **Drupal 8.8, 9, 10, or 11** (`core_version_requirement:
  ^8.8 || ^9 || ^10 || ^11`).
- The **Charts** module (`charts:charts`) and the **Charts Highcharts** backend
  (`charts:charts_highcharts`) — the caption only works with the Highcharts
  library.
- Core's **Views** module — the chart must be built as a View.
- No third‑party PHP or JavaScript libraries of its own (the Highcharts library
  is provided via the Charts Highcharts backend).

## Install with Composer

From the project root:

```bash
composer require drupal/charts_highcharts_caption -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Charts and
Charts Highcharts dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_highcharts_caption -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_highcharts_caption -y
```

## Verify it worked

Edit a View that renders a Highcharts chart and add an item to its **Footer**
section. The caption area provided by this module should be available; add it,
enter some text, and confirm the text appears as a caption inside the rendered
chart.
