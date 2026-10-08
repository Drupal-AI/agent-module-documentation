# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Node** (`node`) and **Views** (`views`) modules — enabled
  automatically as dependencies.

Recommended, optional companions:

- **Charts** module — required only if you want the visual reports from the
  Content Reporting Charts submodule (it uses Highcharts through the Charts
  module).
- **EU Cookie Compliance** (`eu_cookie_compliance`) — needed for the GDPR consent
  tracking features (optional but recommended if you use them).

There are no third‑party Composer or PHP library requirements for the base module.

## Install with Composer

From the project root:

```bash
composer require drupal/content_reporting -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/content_reporting -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en content_reporting -y
```

## Submodules

Content Reporting ships one optional submodule:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Content Reporting Charts** | `content_reporting_charts` | Visual line/bar/pie charts for your reports, via integration with the Charts module (Highcharts). Enable it only if you want charts, and make sure the Charts module is installed first. |

Enable it with:

```bash
drush en content_reporting_charts -y
```

## Verify it worked

After enabling, look under the **Reports** section of the admin menu for the new
Content Reporting dashboards. As pages are viewed, background tracking begins
populating the data. If you enabled the charts submodule (with the Charts module
present), the visual reports should render there too. See the main guide's
[How to use it](../index.md#how-to-use-it) section for what to review — including
access control and performance on larger sites.
