# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- **PHP 7.2 or later.**
- The **External Entities** module (`external_entities`, 3.0.0‑beta1 or later) —
  the `gbif2_entity` submodule relies on it for Entity API integration with GBIF's
  remote data.
- The `resttelae/gbif` PHP client library, which Composer pulls in automatically
  when you install the module.

## Install with Composer

From the project root:

```bash
composer require drupal/gbif2 -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer pull in the External
Entities module and the `resttelae/gbif` library as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/gbif2 -W`, `ddev drush …`. Inside
> the container (`ddev ssh`) run them without the prefix.

## Enable the module

Enable the base module plus the pieces you need:

```bash
drush en gbif2 gbif2_entity gbif2_views -y
```

## Submodules

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **GBIF Entity** | `gbif2_entity` | The storage client (`gbif`) that lets you create External Entity types backed by GBIF occurrences. |
| **GBIF Views** | `gbif2_views` | The Views query, field, and filter plugins for building "GBIF occurrences" views, plus a Views Bulk Operations subscriber. |

## Verify it worked

Log in as an administrator and confirm **GBIF**, **GBIF Entity**, and **GBIF
Views** appear as enabled on the **Extend** page (`/admin/modules`). Then create
an external entity type using the **gbif** storage client and add a View of type
**GBIF occurrences** to confirm records load from the GBIF API.
