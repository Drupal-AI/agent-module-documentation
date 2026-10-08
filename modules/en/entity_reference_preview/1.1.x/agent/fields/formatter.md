<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Formatter: entity_reference_entity_view_preview

`src/Plugin/Field/FieldFormatter/EntityReferenceEntityPreviewFormatter.php`

- `@FieldFormatter` id **`entity_reference_entity_view_preview`**, label *"Rendered entity (with
  preview)"*, `field_types = { "entity_reference" }`. Extends core
  `EntityReferenceEntityFormatter`, so its settings/schema mirror the core "Rendered entity"
  formatter: `view_mode` (string) + `link` (boolean). Schema key
  `field.formatter.settings.entity_reference_entity_view_preview` (config/schema).
- Select it per view-display on *Manage display* for any entity-reference field whose references you
  want to preview. Only fields using this formatter participate in preview; nothing else on the page
  is swapped.

## How it works

- `create()` injects `EntityStateManager` and computes `$can_see_indicator` =
  `current_user->hasPermission('view entity_reference_preview indicator')` **AND**
  config `enableDraftIndicator`.
- `prepareView(array $entities_items)`: if the target storage is a `RevisionableStorageInterface`
  **and** `EntityStateManager::isPreviewing()` is TRUE → `preparePreviewView()`; otherwise defers to
  `parent::prepareView()` (normal published rendering).
- `preparePreviewView()`: collects `target_id`s, calls
  `EntityStateManager::findRevisionIds($target_type, $target_ids)` to resolve each reference's latest
  revision id, then `loadMultipleRevisions()` and assigns the loaded revision to `$item->entity` with
  `$item->_loaded = TRUE`. It does **not** itself decide visibility.
- `viewElements()`: calls `parent::viewElements()` — core's `getEntitiesToView()` runs
  `checkAccess()` → `$entity->access('view', NULL, TRUE)` on the (possibly swapped) revision, so
  access is enforced on whatever revision was loaded. When `$can_see_indicator` is TRUE and not
  currently previewing, it flags each non-live entity (`_show_preview_indicator`) and adds the draft
  indicator cache contexts; the indicator markup itself is added in `hook_entity_view_alter()`.
- Cache: adds `user.permissions`, the `entity_reference_preview` context, and a
  with/without-indicator context; tags `erp_draft_indicator`.

## Notes

- Preview only affects **revisionable** target types (paragraphs, nodes, media, etc.); non-revisionable
  references fall through to the normal formatter.
- "Latest revision" is negotiated with translation/language fallback — see
  [../api/preview-mechanism.md](../api/preview-mechanism.md).
