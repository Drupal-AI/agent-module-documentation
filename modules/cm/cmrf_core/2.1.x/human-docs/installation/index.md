# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- A reachable **CiviCRM instance** with REST API access, and an API user with
  credentials (API key + site key).

CiviMRF Core has no hard Drupal module dependencies of its own. Individual
submodules add their own: `cmrf_views` builds on core's Views, and `cmrf_webform`
requires the [Webform](https://www.drupal.org/project/webform) module.

There are no third‑party PHP library requirements.

> **Note:** this project is not covered by Drupal's security advisory policy.

## Install with Composer

From the project root:

```bash
composer require drupal/cmrf_core -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/cmrf_core -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the core framework first:

```bash
drush en cmrf_core -y
```

## Submodules — enable only what you need

The core module is the connection framework; the submodules are what you actually
build with. Enable them individually with `drush en`:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Views** | `cmrf_views` | Exposes CiviCRM API calls as Views data sources, so you build CRM‑backed listings with the ordinary Views UI. |
| **Webform** | `cmrf_webform` | Posts Webform submissions into CiviCRM. Requires the Webform module. |
| **Call Report** | `cmrf_call_report` | Records the API calls that were made — useful for debugging and monitoring. |
| **Example** | `cmrf_example` | Example code demonstrating how to use the framework. |

For example, to build CRM‑backed Views:

```bash
drush en cmrf_views -y
```

## Verify it worked

Confirm the module is enabled at **Extend** (`/admin/modules`). Nothing talks to
CiviCRM until you create a connection — continue to
[Configuration](../configuration/index.md).
