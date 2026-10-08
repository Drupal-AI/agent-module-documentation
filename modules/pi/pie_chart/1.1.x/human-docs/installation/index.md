# Installation

## Requirements

Pie Chart needs:

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- An **internet connection at render time** — the charts are drawn with **Google
  Charts**, which is loaded from Google's servers. Without internet access the
  chart block hides itself.

There are no third‑party Composer library requirements and no module dependencies
beyond core.

## Install with Composer

From the project root:

```bash
composer require drupal/pie_chart -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/pie_chart -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en pie_chart -y
```

## Verify it worked

Go to **Structure → Block layout**, click **Place block**, and confirm the Pie
Chart blocks appear in the list. Place one (for example the Name | Value chart),
enter some data, and view the page — the pie chart should render in the region you
chose. If it doesn't appear, check that the site can reach the internet, since the
chart depends on Google Charts. See the [overview](../index.md) for the full
walk‑through.
