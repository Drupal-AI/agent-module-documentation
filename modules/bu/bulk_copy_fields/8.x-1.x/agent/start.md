<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bulk Copy Fields (bulk_copy_fields) — agent index

Core **Action** that copies the value of one field into another **compatible** field across the
content entities selected on a Core Bulk Operations listing (e.g. `/admin/content`). Depends on
core `action`. Version **8.x-1.0-alpha6** — **alpha / experimental**. Core `^8 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Not security-advisory covered. ~137 sites.

## What it actually does (verified from source)

- **Auto-creates actions.** `hook_install()` and `hook_entity_operation_alter()`
  (`bulk_copy_fields.module`) iterate **every entity type** and create a configured action
  `bulk_copy_fields_on_<entity_type>`, label `Bulk Copy <Label> Fields`, plugin
  `bulk_copy_fields_action_base`. (The shipped `config/install` file only seeds a `node` action;
  the rest are created at runtime.)
- **Action → tempstore → form.** `BulkCopyFieldsActionBase` (`src/Plugin/Action/`) is a core
  `ActionBase`. `executeMultiple()` stores the selected entity objects in the **private tempstore**
  key `bulk_copy_fields_ids` under the current user id, then the action's
  `confirm_form_route_name` redirects to `bulk_copy_fields.form`. `access()` returns
  `$object->access('update', $account)`, so core's bulk form only passes entities the user may update.
- **Four-step form** `BulkCopyFieldsForm` (`src/Form/`, route `/admin/bulk_copy_fields`, permission
  `administer bulk_copy_fields`): step 0 pick languages/translations; step 1 pick source field(s)
  from the union of all selected entities' field definitions; step 2 map each source field to a
  destination field of the **same (loosened) type**; step 3 confirm → Batch.
- **The copy** happens in `BulkCopyFields::copyFields()` (`src/BulkCopyFields.php`), a Batch
  operation: for each entity, for each chosen translation, for each `field_from => field_to`, it
  reads `$entity->get($field_from)->getValue()`, runs `processField()`/`processDate()` conversions,
  validates entity-reference `target_type`/`target_bundles`, calls
  `$entity->get($field_to)->setValue($values)`, sets a new revision for nodes, and `$entity->save()`.
- **Type matching** (`validateForm` step 1): `created`/`changed`/`date`/`daterange` → `datetime`;
  `entity_reference_revisions` → `entity_reference`; `string_long` ↔ `text_with_summary`. Only
  same-normalised-type fields are offered as destinations. Reference copies drop items whose bundle
  the destination forbids (with a warning); `entity_reference` → `entity_reference_revisions` fills
  `target_revision_id` from the loaded target.

## Gotchas

- **No undo.** Overwrites the destination field; old value survives only if revisions were kept. The
  form shows a standing warning to test on a database dump first. Explicitly experimental.
- **Partial-conversion data loss is silent.** Rich→plain loses markup; multi→single keeps delta 0.
- **Core Actions only.** Maintainer states it is not designed for the contrib Views Bulk Operations
  module; use the core bulk-update field on the content listing.
- **Bulk save side effects.** Every `$entity->save()` fires normal save hooks (reindex, cache clear,
  workflows, webhooks) — large selections are heavy.
- `execute()` type-hints an unimported `ContentEntityInterface` (irrelevant in the normal
  `executeMultiple` path).

## Files / mechanism detail

- `agent/actions/bulk-copy-fields.md` — the action, the step-through form, the batch, field-type
  rules, and the operator walkthrough.

## Permission

- `administer bulk_copy_fields` (`restrict access: TRUE`) gates the confirm form/route. Selection is
  additionally filtered by each entity's `update` access at action time.
