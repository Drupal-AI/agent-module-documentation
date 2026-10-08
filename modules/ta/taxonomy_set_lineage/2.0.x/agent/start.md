<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Taxonomy Set Lineage (taxonomy_set_lineage) — agent index

Automatically materialises a term's **ancestors** into an entity's taxonomy reference fields on save.
When a content entity is presaved, `hook_entity_presave` (in `taxonomy_set_lineage.module`) checks the
module's config (`taxonomy_set_lineage.settings`): if a scoped entity-reference→`taxonomy_term` field's
term set **changed**, it loads each selected term's parents with
`taxonomy_term` storage `loadAllParents($tid)` and inserts any missing ancestors immediately before the
child term (root→child order). It **only adds** values, never removes them, and only touches fields whose
value differs from `$entity->original`. There are **no services, no permissions of its own, and no drush**;
the only moving parts are the presave hook, a settings form, and a node bulk action.

The scope is controlled entirely by `taxonomy_set_lineage.settings` (keys `vocabulary`, `entities`,
`bundles`, `fields`). `vocabulary` is required and lists the vocabularies in play; if `entities`,
`bundles` and `fields` are all empty the module operates on **every** entity-reference→taxonomy_term
field that targets one of those vocabularies, otherwise it narrows to the chosen entity types, bundles,
or specific field-config ids. A separate node Action (`taxonomy_set_lineage_update_node`, "Update Taxonomy
Term Parents") applies the same parent-filling to selected nodes from `/admin/content` for backfilling
existing content — it ignores the changed-check and always adds missing parents, then saves.

- Depends on: nothing hard (`.info.yml` declares no `dependencies`). The bundled optional config for the
  action enforces `node` + `taxonomy` for that action only.
- Core: `^9 || ^10 || ^11`. Package: `Taxonomy`.
- Settings page: **yes** — `configure: taxonomy_set_lineage.taxonomy_set_lineage_vocabulary_form`
  (`/admin/config/content/taxonomy_set_lineage`), gated by the core permission `administer taxonomy`.
- Defines **no** permissions, **no** services, **no** drush commands, **no** plugin types. Provides config
  schema. Provides one core `Action` plugin instance and one core `hook_entity_presave` implementation.

## What you'd do → where

- **Choose which vocabularies / entity types / bundles / fields get lineage** →
  [configure/settings.md](configure/settings.md)
- **Understand exactly when and how parents get added on save (the mechanism, edge cases, cardinality,
  term-move staleness)** → [hooks/presave.md](hooks/presave.md)
- **Backfill parents on existing nodes in bulk from the content admin page** →
  [plugins/action.md](plugins/action.md)

## Key facts (real machine names)

- Route / form: `taxonomy_set_lineage.taxonomy_set_lineage_vocabulary_form`
  (`/admin/config/content/taxonomy_set_lineage`, `_permission: 'administer taxonomy'`), form
  `Drupal\taxonomy_set_lineage\Form\TaxonomySetLineageForm` (form id `taxonomy_set_lineage_vocabulary_form`).
  Menu link (same route) under `system.admin_config_content`.
- Config object: `taxonomy_set_lineage.settings` — keys `vocabulary`, `entities`, `bundles`, `fields`
  (each a sequence of strings; schema in `config/schema/taxonomy_set_lineage.schema.yml`).
- Hook: `taxonomy_set_lineage_entity_presave($entity)` in `taxonomy_set_lineage.module`.
- Private helpers (in `.module`): `_taxonomy_set_lineage_get_fields($entity, $vocabulary)`,
  `_taxonomy_set_lineage_get_view_vocabularies($view_id, $display_id)`.
- Action plugin: id `taxonomy_set_lineage_update_node`, class
  `Drupal\taxonomy_set_lineage\Plugin\Action\UpdateNode`, `type = node`, label "Update Taxonomy Term
  Parents"; `access()` requires `administer taxonomy`. Optional install config
  `system.action.taxonomy_set_lineage_update_node` (enforced deps `node`, `taxonomy`).
- No `*.services.yml`, no `*.permissions.yml`, no drush, no libraries, no templates.
