# Installation

## Requirements

- **Drupal 10 or 11** (`core_version_requirement: ^10 || ^11`).
- Core's **Migrate** module (`migrate`) — a required dependency; Drupal enables it
  automatically.
- Practically, revisionable and fieldable entity types (such as nodes). The
  module is most useful when your site uses **revisions and non‑default drafts**.
- **Content Moderation** (core) is recommended — not a package dependency, but the
  whole point of the plugin is sites where drafts run ahead of published content.

There are no third‑party Composer libraries.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_forward_draft -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer update any shared
dependencies as needed.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_forward_draft -W`,
> `ddev drush …`. Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_forward_draft -y
```

## Verify it worked

There is no admin page. Point a migration's destination at
`entity_with_forward_draft:node` (see
[the module overview](../index.md#how-to-use-it)), then, on test data that has a
real forward draft, re‑run the migration and confirm the published revision
refreshes while the draft is replayed as a new non‑default revision rather than
being clobbered.
