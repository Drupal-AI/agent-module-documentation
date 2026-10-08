# Installation

## Requirements

AI Migration ties together the AI framework with Drupal's migration and schema
tooling. It needs:

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- The **AI** module (`ai`) — enabled and configured with a working AI provider.
- Core's **JSON:API**, **Migrate**, and **Serialization** modules.
- The **Migrate Plus** module (`migrate_plus`).
- The **Schemata** module (`schemata` / `schemata_json_schema`) — this exposes the
  JSON schema the module reads to build mappings.

Some of these (Schemata, Migrate Plus) are contrib and are pulled in by Composer;
the JSON:API, Migrate and Serialization modules ship with core and are enabled as
dependencies.

## Install with Composer

From the project root:

```bash
composer require drupal/ai_migration -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in and update shared
dependencies such as the AI module, Migrate Plus, and Schemata.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/ai_migration -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en ai_migration -y
```

Drupal enables the AI, JSON:API, Migrate, Migrate Plus, Serialization, and
Schemata dependencies for you if they are not already on.

## After enabling

Confirm the **AI** module has a provider configured with a working API key
(stored as a secret via the Key module, per this project's conventions). From
there you use the module to help author migrations from your JSON:API/schema
sources.
