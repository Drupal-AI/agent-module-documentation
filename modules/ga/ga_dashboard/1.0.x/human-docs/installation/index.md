# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- Core's **Views** module (enabled by default).
- **Charts** (`charts`) and its **Charts Google** (`charts_google`) submodule —
  these render the graphs.
- **Google Analytics Reports** (`google_analytics_reports`) — this supplies the
  report data and the Google authentication.
- A **Google Analytics property** and a Google Cloud project you can authenticate
  against.

> For smoother loading of report blocks, the project also recommends installing
> and setting up the **Ajaxblocks** module — optional, not required.

## Install with Composer

From the project root:

```bash
composer require drupal/ga_dashboard -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the Charts and
Google Analytics Reports dependencies and update shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/ga_dashboard -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the dashboard together with the chart renderer and reports modules:

```bash
drush en ga_dashboard charts charts_google google_analytics_reports -y
```

## Authenticate with Google

This is the essential setup step, and it happens in the **Google Analytics
Reports** module, not in ga_dashboard:

1. Go to **Configuration → System → Google Analytics Reports API**
   (`/admin/config/system/google-analytics-reports-api`).
2. Follow the on‑page instructions to create a project in the Google Developers
   Console and authenticate your site with Google.

Any credentials or secrets involved here are managed by Google Analytics Reports —
keep API secrets out of version control and, where the module supports it, store
them via environment variables / a Key entity rather than pasting them into code.

## Verify it worked

Once authenticated, visit **`/admin/ga-dashboard`**. The report charts (sessions,
pageviews, top pages, top cities, site speed, top sources) should render on one
page. If they are empty, revisit the Google Analytics Reports authentication step.
