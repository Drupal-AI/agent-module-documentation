# Installation

## Requirements

- **Drupal 10.3 or newer, or Drupal 11** (`core_version_requirement:
  ^10.3 || ^11`).
- The **Charts** module (`charts:charts`), which provides the framework this
  backend renders into.
- The **Apache ECharts** JavaScript library. Follow the Charts module's library
  installation guidance to make the ECharts assets available (typically under
  your site's `libraries` directory), and check the site's status report after
  installing.

## Install with Composer

From the project root:

```bash
composer require drupal/charts_echarts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in the Charts
dependency and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts_echarts -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts_echarts -y
```

## Submodules

- **ECharts API example** (`charts_echarts_api_example`) — an optional example
  submodule that demonstrates building an ECharts chart through the Charts API in
  code. Enable it on a development site if you want a worked reference:

  ```bash
  drush en charts_echarts_api_example -y
  ```

## Select ECharts as your charting library

1. Go to **Configuration → Content authoring → Charts**
   (`/admin/config/content/charts`).
2. Choose **Apache ECharts** as your charting library and save.

## Verify it worked

Build a quick chart — for example a View with the **Chart** format, or a **Chart**
field on an entity type — with ECharts selected as the library, and confirm it
renders. If the site reports the ECharts library is missing, revisit the library
installation step and check the status report at `/admin/reports/status`.
