# Bulk action — "Update Taxonomy Term Parents"

A core `Action` plugin for backfilling ancestors on existing nodes without re-editing each one. This is
**not** a plugin type the module defines — it is a single `@Action` plugin of type `node`.

## Plugin facts

- Id: `taxonomy_set_lineage_update_node`. Class:
  `Drupal\taxonomy_set_lineage\Plugin\Action\UpdateNode` (extends `ActionBase`, implements
  `ContainerFactoryPluginInterface`).
- `type = node`, label "Update Taxonomy Term Parents". Injects `config.factory` and `entity_type.manager`.
- Enabled as a system action via optional config `system.action.taxonomy_set_lineage_update_node`
  (`config/optional/`, enforced deps `node` + `taxonomy`), so it appears in the *Action* dropdown on
  `/admin/content`.

## Access

`access($entity, $account, $return_as_object)` →
`AccessResult::allowedIfHasPermission($account, 'administer taxonomy')`. Only users with **administer
taxonomy** can run it. (Same permission that gates the settings form.)

## What `execute($entity)` does (`UpdateNode.php:74-153`)

Resolves the same lineage fields as the presave hook (identical `entities`/`bundles`/`fields` scoping,
using `_taxonomy_set_lineage_get_fields()` / `_taxonomy_set_lineage_get_view_vocabularies()`), then for
each field adds any missing ancestors of the current terms and calls `$entity->save()`.

Two deliberate differences from the presave hook:

- **No change-check.** The action does not compare against `$entity->original`; it always computes
  parents for the current term set. This is what makes it a backfill tool — it repairs content saved
  before the module was configured, or whose vocabulary was re-parented afterwards.
- **It saves the entity itself** (`$entity->save()`), which in turn triggers `hook_entity_presave` again,
  but that pass is a no-op here because the action already added the parents.

Like the hook it is **add-only** (never removes terms) and subject to field cardinality.

## Using it

`/admin/content` → select nodes → choose **Update Taxonomy Term Parents** → *Apply to selected items*.
Configure `taxonomy_set_lineage.settings` first (at minimum `vocabulary`), or there are no lineage fields
to act on. Covered by `TaxonomySetLineageContentTest::testSave()`, which runs the action from the content
admin page and asserts the parent terms appear afterwards.
