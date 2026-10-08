# Installation

## Requirements

- **Drupal 10.1 or 11** (`core_version_requirement: ^10.1 || ^11`).
- **Search API Solr** (`search_api_solr`), with one or more configured Solr
  servers — this module inspects those servers.
- Your canonical Solr config stored somewhere the site can read it, typically
  committed alongside your Drupal code in the repository.

There are no third-party PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_solr_schema_check -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_solr_schema_check -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_solr_schema_check -y
```

## Point it at your canonical config, then check

Configure the module with the location of your Solr config in your repository — the
schema you consider the source of truth. Then go to **Reports → Status report**
(`/admin/reports/status`).

## Verify it worked

On the Status report you should see a "Checked" section listing each config file
against each configured Solr server. If everything matches, those entries confirm
it; if a file differs, you'll see an Error naming the server and file. Either
outcome means the module is running and comparing correctly.
