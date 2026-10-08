# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- No module dependencies. The CO2.js calculation library ships with the module.

There are no additional PHP or third-party library requirements to install
separately.

## Install with Composer

From the project root:

```bash
composer require drupal/carbon_impact_evaluator -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/carbon_impact_evaluator -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en carbon_impact_evaluator -y
```

If you are upgrading an existing installation, run database updates afterwards so the
data table picks up the latest fixes:

```bash
drush updb -y
```

## Verify it worked

Configure the module (see [Configuration](../configuration/index.md)), browse a few
pages of your site, then visit `/carbon-impact-evaluator/table`. You should see a
table recording estimated carbon emissions for the pages visited since the module was
enabled.
