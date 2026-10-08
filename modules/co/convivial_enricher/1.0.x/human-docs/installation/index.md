# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2||^11`).
- The **Convivial Core** module (`convivial_core`) — Convivial Enricher depends on
  it, and Composer/Drupal will bring it in as a dependency.
- To pull *real* enrichment data you also need an external data source and its
  credentials — for example an **ActiveCampaign** account if you use the bundled
  Enricher ActiveCampaign submodule.

There are no additional third‑party PHP or JavaScript library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/convivial_enricher -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in Convivial Core and
update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/convivial_enricher -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en convivial_enricher -y
```

This also enables **Convivial Core** if it is not already on.

## Enable a datasource

Enriching profiles needs at least one datasource. The module ships a *dummy*
datasource for testing, plus a bundled **Enricher ActiveCampaign** submodule for
real ActiveCampaign data:

```bash
drush en convivial_enricher_activecampaign -y
```

(Enable the submodule that matches your provider, or provide your own datasource
plugin.) Store any provider API credentials as environment‑backed secrets — do not
commit them to configuration.

## Verify it worked

Go to **Web services → Enrichers**. You should see the enrichers list page, where
a user with the **Administer enrichers** permission can add and configure an
enricher. Start by testing with the dummy datasource before wiring in a live
provider.
