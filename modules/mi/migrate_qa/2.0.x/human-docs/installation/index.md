# Installation

## Requirements

Migrate QA builds on several other modules. It needs:

- **Drupal 8, 9, or 10** (`core_version_requirement: ^8 || ^9 || ^10`). Check the
  project page for the latest Drupal 11 status before using it on a D11 site.
- The following modules enabled (Composer will pull in the contributed ones):
  - **Diff** (`diff`) — for revision diffs of Trackers.
  - Core **Field** (`field`).
  - Core **Migrate** (`migrate`).
  - Core **Taxonomy** (`taxonomy`) — for tagging Trackers/Issues/Flags.
  - **Dynamic Entity Reference** (`dynamic_entity_reference`) — to relate
    Trackers to any content entity.
  - **Migrate Plus** (`migrate_plus`) and **Migrate Tools** (`migrate_tools`) —
    the migration workflow Migrate QA integrates with.

There are no additional PHP library requirements.

## Install with Composer

From the project root:

```bash
composer require drupal/migrate_qa -W
```

The `-W` (`--with-all-dependencies`) flag lets Composer bring in Diff, Dynamic
Entity Reference, Migrate Plus, Migrate Tools, and their shared dependencies.

> **Using DDEV?** Prefix Composer and Drush with `ddev` when you run from your
> host machine — `ddev composer require drupal/migrate_qa -W`, `ddev drush …`.
> Inside the container (`ddev ssh`) run them without the prefix.

## Enable the module

```bash
drush en migrate_qa -y
```

Drupal enables the required dependency modules along with it.

## Submodules — enable only what you need

| Submodule | Machine name | What it adds |
|-----------|--------------|--------------|
| **Migrate QA Views** | `migrate_qa_views` | Ready‑made Views for the QA listings and reports. Needs `views_bulk_operations` and `views_bulk_edit`. Most sites will want this. |
| **Migrate QA Views Media** | `migrate_qa_views_media` | Additional media‑specific QA views. |
| **Migrate QA Demo Data** | `migrate_qa_demo_data` | Example QA data so you can see the tool working. Needs `migrate_source_csv`. |

Enable them individually, for example:

```bash
drush en migrate_qa_views -y
```

## Verify it worked

Log in as an administrator and go to **Structure → Migrate QA**
(`/admin/structure/migrate-qa`). You should see the Tracker, Issue, Connector,
and Flag areas. If you enabled **Migrate QA Views**, the QA listing views should
also be available. Grant the relevant `administer migrate_qa_* entity` and
`edit migrate_qa_tracker entity` permissions to the roles that will do QA work.
