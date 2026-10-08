# Installation

## Requirements

- **Drupal 10 or newer** (`core_version_requirement: >=10.0`).
- **PHP 8.1 or newer.**
- Core's **Migrate** module (`migrate`).
- **[Migrate Plus](https://www.drupal.org/project/migrate_plus)**
  (`migrate_plus`) — a required dependency, pulled in by Composer. This module
  extends its JSON data parser.
- Network access from your Drupal server to the remote JSON:API host you intend to
  import from.

There are no additional PHP library requirements.

> This project is **not covered by Drupal's security advisory policy** and is
> minimally maintained — fine for a controlled migration, but review it before
> relying on it in production.

## Install with Composer

From the project root:

```bash
composer require drupal/migration_jsonapi -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed, and pulls in Migrate Plus.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/migration_jsonapi -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migration_jsonapi -y
```

That's all it takes. There is no configuration form — the `jsonapi` data parser is
now available to any Migrate Plus `url` source.

## Verify it worked

Write a migration whose source uses `data_parser_plugin: jsonapi` with a
`jsonapi_host`, `jsonapi_prefix`, and `jsonapi_endpoint` (see the
[main guide](../index.md)), then run `drush migrate:status` to confirm it is
registered and `drush migrate:import <migration_id>` to run it. Each generated
JSON:API URL is written to the `jsonapi` logger channel, so check the logs
(`drush watchdog:show`) to see exactly which URLs were fetched.
