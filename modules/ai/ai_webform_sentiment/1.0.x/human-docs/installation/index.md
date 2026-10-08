# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2 || ^11`).
- The **[Webform](https://www.drupal.org/project/webform)** module (`webform`) —
  the source of the submissions analyzed.
- The **[AI](https://www.drupal.org/project/ai)** module (`ai`), configured with
  a working AI provider whose API key is stored as a secret (via the Key module).
- The **Chart.js API** module (`chartjs_api`) — used to draw the sentiment
  charts.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_webform_sentiment -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Chart.js API
module and any shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_webform_sentiment -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_webform_sentiment -y
```

This ensures `ai`, `webform`, and `chartjs_api` are enabled too. Then grant the
module's permission to the staff who should view the sentiment analysis.
