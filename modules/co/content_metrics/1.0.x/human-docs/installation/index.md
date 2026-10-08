# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **ChartJS API** module (`chartjs_api`) — this is a required dependency and
  is what actually draws the charts.

There are no third‑party PHP library requirements beyond the ChartJS API module.

## Install with Composer

From the project root:

```bash
composer require drupal/content_metrics -W
```

The `-W` (`--with-all-dependencies`) flag pulls in the ChartJS API module and
updates any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_metrics -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_metrics -y
```

Enabling Content Metrics will also enable ChartJS API if it isn't already on.

## Verify it worked

Open the content-metrics charts as an administrator. You should see charts of
content activity (such as items created per month over the past year) rendered by
ChartJS, each with exposed filters you can adjust. If the charts don't render,
confirm that the **ChartJS API** module is enabled.
