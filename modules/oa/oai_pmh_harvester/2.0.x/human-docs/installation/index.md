# Installation

## Requirements

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`).
- The **Auto Config Form** module (`auto_config_form`) — a required dependency.
- The **`phpoaipmh`** PHP library, which the harvester uses to talk to the OAI-PMH
  provider. It is pulled in through Composer when you install the module.
- An **OAI-PMH provider** to harvest from — for example a Koha catalog's OAI
  endpoint (something like `https://example.com/cgi-bin/koha/oai.pl`).
- Outbound HTTP(S) access from the Drupal server to that provider.

## Install with Composer

From the project root:

```bash
composer require drupal/oai_pmh_harvester -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install `phpoaipmh`, the
Auto Config Form module, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oai_pmh_harvester -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oai_pmh_harvester -y
```

Drupal will enable Auto Config Form first if it is not already on.

## Verify it worked

Visit **Configuration → Web services → OAI-PMH Harvester → Settings**
(`admin/config/services/oai_pmh_harvester/settings_form`) and confirm the form
loads. After [configuring](../configuration/index.md) the endpoint and running a
harvest, confirm the `oai_pmh_harvester_bib_records` table exists and fills with
records.
