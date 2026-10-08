<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The merge tool: routes, form flow, options, Drush

Merge one or more **source** entities into a single **target** (survivor) of the same type. All UI paths render the one form `Form\ContentMergeForm` (`getFormId()` → `entity_reference_manager_form`).

## Install / enable

`composer require drupal/entity_reference_manager` then `drush en entity_reference_manager`. No dependencies, no config to import. Grant the `administer entity reference manager` permission to the roles that should merge content.

## Routes (`entity_reference_manager.routing.yml`)

| Route | Path |
|---|---|
| `entity_reference_manager.form` | `/admin/content/entity-reference-manager` |
| `entity_reference_manager.node_merge` | `/node/{node}/manage-references` |
| `entity_reference_manager.taxonomy_merge` | `/taxonomy/term/{taxonomy_term}/manage-references` |
| `entity_reference_manager.media_merge` | `/media/{media}/manage-references` |

The per-entity routes pass `entity_type` in route defaults and upcast the entity parameter; `_admin_route: TRUE` is set for theming only. Grant the `administer entity reference manager` permission to the roles that should be able to run merges.

## Menu, tabs, operations

- `links.menu.yml`: admin link *Entity Reference Manager* under `system.admin_content` → `entity_reference_manager.form`.
- `links.task.yml`: a **Merge** local task on the canonical route of node, taxonomy_term, and media.
- `entity_reference_manager.module` `hook_entity_operation()`: adds a **Merge** operation (weight 50) to node/term/media rows, linking to the matching per-entity route; the operation link is shown only to users with `administer entity reference manager`.

## Form flow (`ContentMergeForm`)

1. **`buildForm()`** — reads the current route params; if a node/term/media is in the path it auto-selects that entity type (rendered as a hidden field), prefills that entity as the source, and hides the bundle. On the central form the user picks **Entity type** (taxonomy_term / node / media) and **Bundle** (both AJAX-rebuild the wrapper). Source/target are `entity_autocomplete` elements (`#target_type` = entity type; `target_bundles` selection setting when a bundle is chosen; source has `#tags = TRUE` for multiple). An intro/help fieldset shows once and is dismissed via an AJAX "Close" button that sets `hide_intro_message` in the `entity_reference_manager` private tempstore.
2. **Options** (`details`): `keep_source` checkbox (*Keep source entity after merge*, default off) and `update_revisions` checkbox (*Update references in revisions too*, default off).
3. **`validateForm()`** — requires ≥1 source and that the target is not among the sources ("Source and target must be different entities.").
4. **First `submitForm()` pass** — loads target and each source, calls `ContentMergeManager::analyze()` per source, and stores the aggregated per-field impact in `$form_state->set('confirm_data', …)` then `setRebuild()`. If nothing references the sources it warns "No references to update…".
5. **Confirmation render** — lists each affected field as `@entity_type: @field (@count references)` (plus a separate revisions list when `update_revisions`), with **Confirm and execute merge** and **Cancel** (`cancelSubmit()` clears `confirm_data`).
6. **Second `submitForm()` pass** (confirm) — for each source ≠ target, calls `ContentMergeManager::execute()` with `keep_source`/`update_revisions`, adds a status/error message per source, and redirects back to the current path. The actual work runs as a Batch (see [../api/handlers.md](../api/handlers.md)).

## Options semantics

- **keep_source = FALSE** (default): after references are moved, each source entity is **deleted** (`batchDeleteSource`).
- **keep_source = TRUE**: references are re-pointed but sources are left intact (effectively "copy references to target").
- **update_revisions = TRUE**: also rewrites the reference value inside historical revisions (`batchUpdateFieldReferencesInRevisions`, saved with `setNewRevision(FALSE)`); revision analysis/rewrite queries use `accessCheck(FALSE)` and only apply to revisionable entity types.

## Drush command (`Commands\EntityReferenceManagerCommands`, `drush.services.yml`)

`drush erm-merge` — options `--entity_type` (node|taxonomy_term|media), `--source_ids` (comma-separated), `--target_id`, `--keep_source`, `--update_revisions`. Missing values are prompted interactively. It prints the per-source `analyze()` impact, asks for confirmation, then calls `ContentMergeManager::execute()` per source. Example:

```
drush erm-merge --entity_type=node --source_ids=1,2 --target_id=3 --keep_source --update_revisions
```
