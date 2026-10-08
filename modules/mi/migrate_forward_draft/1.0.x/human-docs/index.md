# Migrate Forward Draft — manual setup guide

**Migrate Forward Draft** (`migrate_forward_draft`) provides a Migrate
**destination plugin** that keeps editors' **draft revisions coherent** when a
migration re‑imports published content. It's built for sites that use **content
moderation and workflows**, where an external feed or API "owns" some fields on a
node while editors are separately working on a newer, unpublished draft — a
so‑called **forward draft**.

The problem it solves is subtle but painful. When you re‑run a migration, Drupal
updates the **default (published) revision**. If an editor's forward draft is
sitting ahead of the live revision, that draft can be left with **stale migrated
values** for the fields the migration owns, or the revision history gets
confusing. This plugin captures the forward draft *before* the import, updates the
default revision from your migration, then **replays the draft as a new
non‑default revision** afterwards — so the published data refreshes without
stranding or overwriting the editor's in‑progress work. You can optionally overlay
selected fields from the freshly imported default onto the replayed draft, so
migration‑owned fields stay in sync while editor‑owned fields are preserved.

There is **no settings form** — you configure everything on the migration's
`destination:` in YAML. It depends on core's **Migrate** module and runs on
**Drupal 10 and 11**. It's most useful on sites running **Content Moderation**
(core) with revisionable, fieldable entity types, though moderation is not a hard
package dependency.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** for this module — you set it up on your
migration's destination, as shown below.

## How to use it

After enabling the module, edit your migration configuration (YAML or exported
config):

1. Set the **destination** to `entity_with_forward_draft:node` (or the appropriate
   derivative for your entity type).
2. Keep your usual destination settings for updating the default revision (for
   example `overwrite_properties`).
3. Add **`forward_revision_overwrite_properties`** listing the property names to
   copy from the newly imported default onto the replayed draft — for example
   migration‑owned titles or IDs. Omit it (or leave it empty) if you only want the
   draft replayed without copying anything from the default.
4. Optionally set **`migration_sync`** to `true` or `false` to control whether the
   main migrate save runs with syncing on (this matters for content moderation and
   custom event subscribers). The forward‑draft replay save never uses syncing.
5. Rebuild caches if needed.

```yaml
destination:
  plugin: entity_with_forward_draft:node
  overwrite_properties:
    - title
    - field_source_id
  forward_revision_overwrite_properties:
    - title
    - field_source_id
  # migration_sync: true
```

> **Test before production.** Because this plugin manipulates revisions, test it
> on a copy of production data that includes real forward drafts before relying on
> it live.
