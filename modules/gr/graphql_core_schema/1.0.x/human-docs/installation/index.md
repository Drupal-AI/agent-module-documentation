# Installation

## Requirements

Graphql Core Schema needs:

- **Drupal 9.3+, 10, or 11** (`core_version_requirement: ^9.3 || ^10 || ^11`).
- **PHP 8.1 or newer**.
- The contrib **GraphQL** module (`drupal/graphql` `^4 || ^5@rc`) — the framework
  this schema plugs into. It is required.
- The **`symfony/string`** library (`^5.4 || ^6 || ^7`) — pulled in automatically
  by Composer.

## Install with Composer

From the project root:

```bash
composer require drupal/graphql_core_schema -W
```

Composer will bring in the GraphQL module and the `symfony/string` library as
dependencies. The `-W` (`--with-all-dependencies`) flag lets it update shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/graphql_core_schema -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

> **GraphQL 4 note:** the project README references some performance patches for
> GraphQL 4 for large schemas. If you run GraphQL 4 and hit schema-build
> performance issues, check the module's README for the relevant patches.

## Enable the module

```bash
drush en graphql_core_schema -y
```

This also enables the GraphQL module if it isn't already on.

## Optional sub-modules

The project ships fourteen optional sub-modules. Enable only the ones you need,
for example:

```bash
drush en graphql_form_schema graphql_security -y
```

| Sub-module | Adds / integrates |
|------------|-------------------|
| `graphql_debugging` | Debug fields (e.g. request headers) for development. |
| `graphql_environment_indicator` | Active environment name/color (Environment Indicator). |
| `graphql_file_url` | File URL fields on the `File` type. |
| `graphql_form_schema` | Entity **create/edit** form mutations + result types. |
| `graphql_masquerade_schema` | Masquerade context query + switch-back mutation. |
| `graphql_media_oembed_schema` | oEmbed resource / iframe URL for media. |
| `graphql_messenger` | Drupal messenger messages collected during resolving. |
| `graphql_metatag_schema` | Metatags for routes/entities (Metatag). |
| `graphql_metatag_schema_org_schema` | schema.org metatags. |
| `graphql_rokka_schema` | rokka.io image URLs (Rokka). |
| `graphql_security` | Route-level access checks on GraphQL endpoints. |
| `graphql_tablefield_schema` | Structured table data (Tablefield). |
| `graphql_telephone` | Parsed/formatted phone numbers (Telephone). |
| `graphql_translatable_config_pages` | Translatable config pages data producer. |

Each sub-module requires the base module (already present once installed above),
and most require the contrib project they integrate — Composer/Drush will prompt
if a dependency is missing.

## After enabling

There's no settings page. Go to **Configuration → Web services → GraphQL**
(`/admin/config/graphql`), add a **Server**, select **Core Composable Schema**,
and configure it there — see the [overview](../index.md) for the steps.
