# Installation

## Requirements

- **Drupal 10.3, 11, or 12** (`core_version_requirement: ^10.3 || ^11 || ^12`).
- The contrib **[JS Cookie](https://www.drupal.org/project/js_cookie)**
  (`js_cookie`) and **[JSON Template](https://www.drupal.org/project/json_template)**
  (`json_template`) modules — JSON Template handles the client-side transform of
  the recommendation JSON into HTML. Both are pulled in by Composer with the `-W`
  flag below.
- A **Recombee account and subscription** — Recombee is a hosted service, and you
  will need it to obtain the API credentials you enter during configuration.

## Install with Composer

From the project root:

```bash
composer require drupal/recombee -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer install JS Cookie and
JSON Template and update any shared dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/recombee -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en recombee -y
```

Drupal enables JS Cookie and JSON Template automatically as dependencies.

## Optional but recommended: Search API Recombee

To push your content into the Recombee index (so recommendations can use your
field data and item similarity), also install the companion module:

```bash
composer require drupal/search_api_recombee -W
drush en search_api_recombee -y
```

It is configured like any other Search API backend, but sends content to Recombee
instead of Solr or the database.

## Verify it worked

Open the settings form (`recombee.settings`) and confirm it loads. Nothing will
display until you enter your Recombee credentials and place the tracker and
recommendation blocks — see [Configuration](../configuration/index.md).
