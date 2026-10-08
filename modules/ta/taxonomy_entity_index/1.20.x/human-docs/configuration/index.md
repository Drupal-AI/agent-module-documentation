# Configuration

Unlike many modules, Taxonomy Entity Index does need a moment of setup: it won't
index anything until you tell it which entity types to track. This page walks
through the settings form and the reindex step.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Taxonomy Entity Index**, or navigate directly
   to `/admin/config/system/taxonomy-entity-index`.

## Entity types to index

The heart of the form is a list of checkboxes, one per eligible entity type. Only
content entity types that have their own base table and use an **integer** ID key
appear here — so you'll typically see **Content** (nodes), **Media**, **User**,
**Taxonomy term**, and any custom content entities, but not config entities or
entities keyed by string IDs. Tick every type you want term relationships tracked
for. You must select at least one; the field is required.

Changing this list does **not** retroactively index content that already exists —
it only changes what gets indexed from now on. After you change the selection,
run a rebuild (below) so existing content is brought into the table.

## Index revisions

A single checkbox, off by default. Normally the module keeps one set of index
rows reflecting the current version of each entity. Turn this on to keep a
separate row for every historical **revision** as well, so you can query which
terms an entity referenced at any past point in time. It's useful for auditing or
historical reporting, but it makes the table larger and adds work on every save,
so leave it off unless you specifically need per‑revision history.

## Index per field

Also a checkbox, off by default. If the same term is referenced by two different
taxonomy fields on the same entity, the module normally collapses that into a
single row. Turn this on to store a separate row per field, so you can tell which
field a term came from (for example, distinguishing a "Primary category" field
from a "Related topics" field). Leave it off if you don't need to distinguish
between fields.

## Save and rebuild

Click **Save configuration**. Then bring existing content into the index:

- **From the UI:** open the reindex form at
  `/admin/config/system/taxonomy-entity-index/reindex` and run it. This clears
  and rebuilds the table for your configured types using Drupal's batch system,
  so it's safe on large sites.
- **From the command line:**

  ```bash
  drush taxonomy_entity_index:rebuild          # rebuild all configured types
  drush tei:rebuild node,media                 # rebuild only nodes and media
  ```

  The command (aliases `tei:rebuild`, `tei-rebuild`) reloads every entity of the
  named type(s) and re-runs the indexing logic. It clears a type's existing rows
  before reinserting, so it's safe to run repeatedly. Run it after changing which
  types are indexed, or after a bulk import that bypassed normal entity save
  hooks.

From then on the table stays current automatically as editors add, change, or
remove content and terms — you only need to rebuild again after bulk operations
or configuration changes.
