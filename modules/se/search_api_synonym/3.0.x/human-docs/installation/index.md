# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Options** module (`options`) and **Views** module (`views`) — Drupal
  enables both automatically as dependencies.
- No third-party Composer or PHP library requirements.
- A search backend that can consume the exported synonyms. The built-in export
  writes a **Solr** synonyms file, so this module is most useful alongside a
  Solr-backed [Search API](https://www.drupal.org/project/search_api) setup. (The
  synonym management itself works without Solr; the Solr file is the delivery
  format.)

## Install with Composer

From the project root:

```bash
composer require drupal/search_api_synonym -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared dependencies
as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/search_api_synonym -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en search_api_synonym -y
```

There are no submodules. The module ships example import files
(`examples/example.csv`, `examples/example.json`, `examples/solr_synonyms.txt`) you
can use to seed a dictionary.

## Next steps

Head to [Configuration](../configuration/index.md) to add synonym entries, set the
export location and cron schedule, and (optionally) bulk-import from a file.
