# The hierarchy fields and using them in Views

## What gets created

Two integer fields on the `taxonomy_term` entity, added to **every** vocabulary:

| Field name | Label | Meaning |
|---|---|---|
| `field_tax_hierarchical_weight` | Hierarchical Weight | 0-based index of the term in the vocabulary's flattened, hierarchy-ordered tree (parents precede children). |
| `field_tax_hierarchical_depth` | Hierarchical Depth | Nesting level: `count(loadAllParents(tid)) - 1` (top-level terms = 0). |

`FieldStorageConfig` (type `integer`) is created once in `hook_install`; a per-vocabulary `FieldConfig`
is attached by the `views_term_hierarchy_weight_field.fields` service. `hook_entity_insert` calls
`createFields()` for any newly created `taxonomy_vocabulary` (skipped during config sync).

## How values are computed (`*.module`)

- `views_term_hierarchy_weight_field_calculate_and_set_for_tree($tree)` takes `TermStorage::loadTree()`
  output and queues a **Batch** (`batch_size = 25`).
- Each batch (`views_term_hierarchy_weight_field_batch_save_fields`) sets weight = the term's position
  in the flattened tree, depth = parent count − 1, then `$term->save()` — written into **every enabled
  language translation** on multilingual sites.

## When recalculation fires

Submit handlers are appended to these forms:
- `taxonomy_overview_terms` (drag-and-drop reorder and the "reset to alphabetical" action).
- `taxonomy_term_form` (add/edit a term; also the "Save and go to list" button).
- New vocabulary creation (via `hook_entity_insert` → `createFields`).

There is no Drush command or admin action to force a rebuild; save a term or re-submit the overview to
recompute. (Programmatically you can call
`views_term_hierarchy_weight_field_calculate_and_set_for_tree($storage->loadTree($vid))`.)

## Sort a View by tree order

1. Create/edit a View of **Taxonomy terms**.
2. Add field/sort **Hierarchical Weight** (`field_tax_hierarchical_weight`), sort **ascending** — this
   reproduces the exact order of the admin term overview page.
3. Optionally add **Hierarchical Depth** to indent labels or to filter to a single level
   (e.g. depth = 0 for top-level terms only).

The fields are plain entity fields, so all normal Views handlers (filter, sort, group, relationship,
REST export) apply.
