# Migrate - Merge duplicated terms — manual setup guide

**Migrate - Merge duplicated terms** (`migrate_merge_duplicated_terms`) is a small
Migrate process plugin for taxonomy migrations where the source contains the same
term more than once. Instead of importing every duplicate, the plugin migrates
only the **first** occurrence of a term, skips the later rows with the same name,
and — crucially — **maps those skipped source IDs to the one migrated term's ID**.

That mapping is what makes it useful: any other content tagged with the skipped
term IDs will, when you use `migration_lookup`, resolve to the single term that
was actually created. You end up with a clean vocabulary and correctly attached
content, instead of a pile of duplicate terms. If you want to merge terms that
have *different* names into one, you simply rename them to share a name in your
source data (database, CSV, JSON, and so on) and let the plugin do the rest.

Per its project page, the module requires core **Taxonomy** and the contributed
**Migrate Plus** module, and it supports **Drupal 9.1, 10, and 11**. This is a
developer/migration utility that acts on migration mappings — it has no runtime,
content, or access role of its own. There is no admin screen; you configure it
inside your term migration's YAML.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   alongside Taxonomy and Migrate Plus.

There is **no configuration page** for this module. It has no settings form; you
use the `merge_duplicated_terms` plugin from migration YAML as described below.

## How to use it

Add the `merge_duplicated_terms` plugin to the process step that produces the
term name in your taxonomy‑term migration, and point the destination at the
taxonomy‑term entity. For example:

```yaml
process:
  name:
    plugin: merge_duplicated_terms
    source: source_field
destination:
  plugin: 'entity:taxonomy_term'
  default_bundle: vocabulary_id
```

Replace `source_field` with the field that holds the term name and `vocabulary_id`
with your target vocabulary. When the migration runs, the first row for each name
creates the term and every later row with that name is mapped to it.

> **Known issue — ordering with parents:** if the terms in your source have
> parents, order the source so that parents always come *before* their children.
> Otherwise some terms can end up attached to the wrong parent. Test the import on
> a copy of the site and keep a database backup before running it in production.
