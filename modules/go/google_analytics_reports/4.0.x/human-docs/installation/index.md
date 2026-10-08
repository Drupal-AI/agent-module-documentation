# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **File** module (`file`), enabled automatically as a dependency (the
  service‑account key is stored as an uploaded file — private file support is
  recommended for credentials).
- The **Google Analytics Reports API** submodule
  (`google_analytics_reports_api`), which ships in this project and holds the
  credentials and API logic.
- The **`google/analytics-data`** PHP library, pulled in by Composer.
- A **Google Cloud service account** with the *Google Analytics Data API*
  enabled, added as a viewer on your GA4 property, and a downloaded JSON key.
- Optional: the contrib **Charts** module if you want to render GA data as graphs.

## Install with Composer

From the project root:

```bash
composer require drupal/google_analytics_reports -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in the `google/analytics-data` library.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/google_analytics_reports -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable both this module and its required API submodule:

```bash
drush en google_analytics_reports google_analytics_reports_api -y
```

Enabling `google_analytics_reports` also pulls in the API submodule as a
dependency. Once enabled, head to
[Configuration](../configuration/index.md) to supply your GA4 credentials and
import the field list — nothing will return data until you do.
