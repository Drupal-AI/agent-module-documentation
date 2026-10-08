# Installation

## Requirements

- **Drupal 10, 11, or 12** (`core_version_requirement: ^10 || ^11 || ^12`; the
  module's own composer.json declares `^10.6 || ^11 || ^12`).
- PHP requirements are inherited from Drupal core.
- A database supported by Drupal's database layer.
- **Chart.js** and its plugins for the charts page — the module declares these as
  npm-asset dependencies:
  - `npm-asset/chart.js` (^4.4)
  - `npm-asset/chartjs-plugin-zoom` (^2.2)
  - `npm-asset/chartjs-adapter-date-fns` (^3.0)

  Composer pulls these in when you require the module with `-W` (an npm-asset
  repository must be configured in your project, which is standard for most
  Drupal/Composer setups).

> **Note:** This project is minimally maintained and does **not** have official
> security-advisory coverage.

## Install with Composer

From the project root:

```bash
composer require drupal/request_audit -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install the Chart.js
assets and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/request_audit -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en request_audit -y
```

## Run database updates

Enabling the module creates its database tables (`request_audit_rel` and
`request_audit_latency_agg`) if they do not already exist. If they are not created
on enable, run database updates:

```bash
drush updb -y
```

## Verify it worked

Log in as an administrator and open **Configuration → System → Request audit
settings**. Turn logging on (see [Configuration](../configuration/index.md)),
generate some traffic, then visit **Reports → Request Audit Charts** and confirm
the latency chart and URL table populate.
