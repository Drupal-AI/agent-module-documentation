# Installation

## Requirements

- **Drupal 10.2+ or 11** (`core_version_requirement: ^10.2||^11`).
- No required third‑party Composer packages or PHP libraries.
- Optional integrations are detected automatically when installed:
  **[Views](https://www.drupal.org/docs/8/core/modules/views)** (view
  serialization), **[Field Group](https://www.drupal.org/project/field_group)**
  (nested groups), **[Block Field](https://www.drupal.org/project/block_field)**
  (block plugin serialization), and
  **[Paragraphs](https://www.drupal.org/project/paragraphs)** (recursive paragraph
  walking).

## Install with Composer

From the project root:

```bash
composer require drupal/entity_display_json -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your host
> machine — `ddev composer require drupal/entity_display_json -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en entity_display_json -y
```

## Grant the endpoint permission

All three `/ejson` endpoints are gated by the single **"Access Entity Display JSON
endpoints"** permission. Under **People → Permissions**, grant it to the roles or API
consumers that should reach the API. As noted in the [overview](../index.md), the
endpoints still enforce Drupal's normal view access on top of this permission — per-entity,
per-view-display and per-field — so callers see only content and fields they are otherwise
allowed to view.

## Verify it worked

As a user or consumer holding the permission, request `GET /ejson` and confirm you
get a JSON response with the site name, slogan, language map, and homepage pointer.
Then resolve a known path with `GET /ejson/resolve?path=/your-path` and follow it to
`GET /ejson/{entity_type}/{uuid}/{display_id}` to confirm an entity serializes using
its Manage Display configuration.
