# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- No other contributed‑module dependencies for the base module.
- **At least one charting‑library submodule** must be enabled before charts
  render (see below). The library's JavaScript loads from a CDN by default, or
  from a local copy in `/libraries` if you turn the CDN option off.

## Install with Composer

From the project root:

```bash
composer require drupal/charts -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/charts -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en charts -y
```

## Enable a charting library — required

The base module draws nothing by itself. Enable one of the library submodules and
then set it as the default library on the settings form:

| Submodule | Machine name | Charting library |
|-----------|--------------|------------------|
| **Charts Highcharts** | `charts_highcharts` | Highcharts |
| **Charts Chart.js** | `charts_chartjs` | Chart.js |
| **Charts Google** | `charts_google` | Google Charts |
| **Charts Billboard** | `charts_billboard` | Billboard.js |
| **Charts C3** | `charts_c3` | C3.js |

For example, to use Highcharts:

```bash
drush en charts_highcharts -y
```

> Highcharts and Google Charts have their own licensing terms for commercial use —
> check the library's license before deploying to a production site.

## Other optional submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Charts Blocks** | `charts_blocks` | Chart blocks (including a Drupal Canvas–friendly variant) so you can place charts without Views. |
| **Charts API Example** | `charts_api_example` | Worked examples of building charts in code, for developers. |

```bash
drush en charts_blocks -y
```

After enabling a library, open **Configuration → Content authoring → Chart
configuration** and set your **default library** and **default chart type** — see
[Configuration](../configuration/index.md).
