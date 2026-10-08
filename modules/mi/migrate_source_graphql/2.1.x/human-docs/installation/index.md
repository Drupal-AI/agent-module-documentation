# Installation

## Requirements

- **Drupal 8, 9, 10, or 11** (`core_version_requirement: ^8 || ^9 || ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — the only dependency, enabled
  automatically when you turn on this module.
- Network access from your server to the GraphQL endpoint(s) you want to read
  from, plus any credentials that endpoint requires.

There are no third‑party Composer or PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_source_graphql -W
```

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_source_graphql -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_source_graphql -y
```

## Verify it worked

Write a small migration using `plugin: graphql` (the GraphQLZero example in the
[overview](../index.md#how-to-use-it) is a good smoke test since it needs no real
credentials), then run:

```bash
drush migrate:status
drush migrate:import your_migration
```

If rows are discovered and imported, the endpoint is reachable and your query is
valid. For real, paginated APIs, double‑check the imported count against what you
expect — a mismatch usually means pagination needs attention.
