# Installation

## Requirements

- **Drupal 10.5 or 11** (`core_version_requirement: ^10.5 || ^11`).
- **PHP 8.2 or newer**.
- Core's **Migrate** module (`migrate`) — this is the only module dependency,
  and Drupal enables it automatically when you turn on Migrate Plus.

Two features have optional extra requirements:

- **OAuth2 authentication** — needs the `sainsburys/guzzle-oauth2-plugin`
  library (version 3.0). Add it with Composer only if you use the `oauth2`
  authentication plugin.
- **SOAP data parser** — needs PHP's **SOAP** extension (`ext-soap`) installed
  and enabled. Only required if you parse SOAP sources.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_plus -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update shared
dependencies as needed.

To also pull in the OAuth2 authentication library:

```bash
composer require drupal/migrate_plus sainsburys/guzzle-oauth2-plugin:^3.0 -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_plus -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_plus -y
```

Most sites also want **Migrate Tools** for the `drush migrate:*` commands that
run and manage migrations:

```bash
composer require drupal/migrate_tools -W
drush en migrate_tools -y
```

## Submodules — examples only

Migrate Plus ships several **example** submodules to demonstrate the API — you
do not need any of them in production, but they are worth enabling on a
scratch/dev site to learn from their migration YAML:

| Submodule | What it demonstrates |
|-----------|----------------------|
| `migrate_example` | A worked "beer" migration from a legacy database (nodes, users, taxonomy, comments, menu links). |
| `migrate_example_setup` | Sets up the source tables/data used by `migrate_example`. |
| `migrate_example_advanced` | More advanced migration techniques. |
| `migrate_example_advanced_setup` | Source setup for the advanced example. |
| `migrate_json_example` | Importing a product catalog from a JSON source via the `url` source plugin. |

Enable an example (and its setup helper) with `drush en`, for example:

```bash
drush en migrate_example migrate_example_setup -y
```
