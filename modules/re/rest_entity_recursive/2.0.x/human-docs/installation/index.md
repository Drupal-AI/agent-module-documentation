# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`) —
  but see the compatibility warning below before you enable it on Drupal 11.4+.
- No declared module dependencies beyond core; in practice you need a REST service
  (core **RESTful Web Services** / **Serialization**, or JSON:API) exposing the
  entities you want to fetch, so that the `json_recursive` format has something to
  act on.
- No third-party Composer or PHP library requirements.

> **Compatibility warning — read before enabling.** Release 2.0.6-rc8 was verified to
> **fatal on class load under Drupal 11.4** because its normalizer widens a core
> return type, which PHP does not allow. The class cannot load, the fatal surfaces in
> a live response, and it can take Drush down with it — recovery meant editing
> `core.extension` directly to remove the module. Confirm the module works against
> your exact core version on a non-production environment first.

## Install with Composer

From the project root:

```bash
composer require drupal/rest_entity_recursive -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/rest_entity_recursive -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en rest_entity_recursive -y
```

## Submodules

Two optional submodules extend the output for specific entity types — enable them
only if you need them:

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **REST Media Recursive** | `rest_media_recursive` | Exposes Media entities recursively, including image styles. |
| **REST Paragraphs Recursive** | `rest_paragraphs_recursive` | Exposes Paragraphs and items from the Paragraphs Library. |

For example:

```bash
drush en rest_paragraphs_recursive -y
```

## Verify it worked

Request an entity your REST configuration exposes, using the new format:

```
GET https://your-site/node/1?_format=json_recursive&max_depth=3
```

A working install returns the entity with its referenced entities inlined, up to the
depth you set. If instead you get a fatal error or a white screen right after
enabling — especially on Drupal 11.4+ — disable the module via configuration (or by
removing it from `core.extension` and clearing caches) and re-check the
compatibility warning above.
