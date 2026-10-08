# Installation

## Requirements

- **Drupal 9, 10, or 11** (`core_version_requirement: ^9 || ^10 || ^11`).
- Core's **Field** module (`field`) — enabled on any standard Drupal site.
- No third‑party PHP or library requirements. Optionally, **JSON:API** (and
  **JSON:API Extras** / `jsonapi_extras`) if you want the computed relationships
  exposed over the API — Computed relationships configures its fields for
  `jsonapi_extras` automatically when that configuration already exists.

Note this release is a **beta** (1.0.0-beta5) and is not covered by Drupal's
security advisory policy — weigh that before using it on production.

## Install with Composer

From the project root:

```bash
composer require drupal/computed_relationships -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/computed_relationships -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en computed_relationships -y
```

## Verify it worked

After enabling, define a computed relationship and choose the bundles it applies
to (see "How to use it" in the [overview](../index.md#how-to-use-it)). Confirm the
computed reference field appears on those bundles and is populated automatically,
and — if you use JSON:API — that the relationship shows up in the API response.
