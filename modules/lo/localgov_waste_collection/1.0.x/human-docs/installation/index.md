# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **A data provider** — the base module does nothing on its own. You must enable
  and configure at least one provider submodule (CSV, Whitespace, or the example
  provider). See "Submodules" below.

There are no third-party Composer library requirements for the base module. A
provider that talks to an external API (Whitespace) will need that service's
credentials.

## Install with Composer

From the project root:

```bash
composer require drupal/localgov_waste_collection -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/localgov_waste_collection -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en localgov_waste_collection -y
```

## Submodules — a data provider is required

No data providers are installed by default, and **the module will not operate
until one is installed and configured**. Enable the provider you need:

| Submodule | Machine name | What it does |
|-----------|--------------|--------------|
| **CSV provider** | `localgov_waste_collection_csv_provider` | Import property and collection data from CSV files. Good when the council exports schedules as spreadsheets. |
| **Whitespace provider** | `localgov_waste_collection_whitespace_provider` | Integrate with the Whitespace Waste Management platform via its API. Needs Whitespace API credentials — treat them as secrets. |
| **Example provider** | `localgov_waste_collection_example_provider` | A very simple demonstration provider, useful for trying the module out. Not for production data. |

For example, to enable the CSV provider:

```bash
drush en localgov_waste_collection_csv_provider -y
```

Each provider has its own `README.md` with details of how it sources data. After
enabling one, continue to [Configuration](../configuration/index.md) to select it
as the active provider.

## Verify it worked

Log in as an administrator and visit **Configuration → Web services → Waste
collection → Settings** (`/admin/config/services/waste-collection/settings`). You
should see the settings form with your enabled provider available for selection.
Once a provider is chosen and configured, visit the front-end base path
(`/waste-collection-schedule` by default) and try a postcode search.
