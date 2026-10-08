# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10||^11`).
- **Metatag DC** (`metatag:metatag_dc`) — a required dependency providing the Dublin
  Core metatags.
- **REST OAI-PMH** (`rest_oai_pmh:rest_oai_pmh`) — a required dependency that serves
  the OAI-PMH endpoint.
- An **Islandora** repository — the module assumes you are running Islandora.
- **Recommended:** Token, Islandora, and Controlled Access Terms, which the metadata
  mapping is designed to work alongside.

## Install with Composer

From the project root:

```bash
composer require drupal/oaipmh_lac -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install Metatag DC, REST
OAI-PMH, and any other shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/oaipmh_lac -W`, `ddev drush …`. Inside the
> container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en oaipmh_lac -y
```

Drupal will enable Metatag DC and REST OAI-PMH first if they are not already on.

## Verify it worked

Confirm the module is enabled alongside REST OAI-PMH and Metatag DC. After
[configuring](../configuration/index.md) the feed through those modules' UIs,
request your OAI-PMH endpoint and confirm the Dublin Core metadata is returned in
the LAC (`oai_lac`) format.
