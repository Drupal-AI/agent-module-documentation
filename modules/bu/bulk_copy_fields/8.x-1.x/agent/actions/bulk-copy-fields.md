<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The Bulk Copy Fields action, form, and batch

## Plugin

`src/Plugin/Action/BulkCopyFieldsActionBase.php` — annotation:

```php
@Action(
  id = "bulk_copy_fields_action_base",
  type = "node",
  confirm_form_route_name = "bulk_copy_fields.form"
)
```

Extends `Drupal\Core\Action\ActionBase`, implements `ContainerFactoryPluginInterface`. Injected:
`tempstore.private`, `session_manager`, `current_user`.

- `access($object, $account, $return_as_object)` → `return $object->access('update', $account, $return_as_object);`
  So when core's bulk-operations field applies the action, it only includes entities the acting user
  can **update**.
- `executeMultiple(array $entities)` builds `$ids[$entity->id()] = $entity` and stores the array in
  the private tempstore collection `bulk_copy_fields_ids` under `current_user->id()`. It does **not**
  copy anything itself — the copy happens later in the form's batch.
- `execute($entity)` delegates to `executeMultiple([$entity])` (note: its `ContentEntityInterface`
  type hint is not imported, but the single-entity path is not used by the bulk flow).

## Configured actions (one per entity type)

`bulk_copy_fields.module`:

- `_bulk_copy_fields_create_action($machine_name, $label)` creates a `system.action` config entity
  `bulk_copy_fields_on_<entity_type>`, `type => <entity_type>`, `plugin => bulk_copy_fields_action_base`.
- `hook_install()` (`bulk_copy_fields.install`) creates one for **every** entity type definition.
- `hook_entity_operation_alter()` re-scans the `config` table (raw DB query, by the maintainer's own
  admission a workaround for OOM issues) and creates any action that does not yet exist — so new
  entity types get an action lazily. The shipped `config/install/system.action.bulk_copy_fields_to_another_field.yml`
  only defines a single `node`-typed action.

## Route / permission

`bulk_copy_fields.routing.yml`:

```yaml
bulk_copy_fields.form:
  path: /admin/bulk_copy_fields
  defaults: { _form: '\Drupal\bulk_copy_fields\Form\BulkCopyFieldsForm' }
  options: { _admin_route: TRUE }
  requirements: { _permission: 'administer bulk_copy_fields' }
```

`bulk_copy_fields.permissions.yml` defines `administer bulk_copy_fields` with `restrict access: TRUE`.

## The step-through form

`src/Form/BulkCopyFieldsForm.php` extends `FormBase` (so it is CSRF-protected) and keeps a
`protected $step` counter plus `$userInput`. Each `submitForm` calls `$form_state->setRebuild()`
and increments `$step`.

- **Step 0 — languages.** Loads the selected entities from tempstore
  (`bulk_copy_fields_ids` / current user). Renders a `tableselect` of all installed languages
  (`STATE_ALL`). `validateForm` stores `$userInput['languages']`; error if none selected.
- **Step 1 — source fields.** Renders a `tableselect` of the union of `getFieldDefinitions()` names
  across the selected entities (includes base fields such as `uid`, `status`, `title`, `created`).
  `validateForm` computes, per field, the **normalised type** and, for each chosen source, the set
  of other fields sharing that type — offered as copy destinations. Normalisation:
  `created|changed|date|daterange → datetime`; anything containing `entity_reference_revisions →
  entity_reference`; `string_long|text_with_summary → string_long_or_text_with_summary`. Error if a
  chosen source has no same-type destination.
- **Step 2 — map destinations.** For each source field a `select` of same-type destination fields.
  `submitForm` merges the chosen `field_from => field_to` map into `$userInput['fields']`.
- **Step 3 — confirm.** "Are you sure you want to copy N fields on M entities?", submit label
  "Copy Fields". `submitForm` calls `bulkCopyFields()` which sets the batch and rebuilds routes.

A standing warning is shown on every step: *"This module is experimental. PLEASE do not use on
production databases without prior testing and a complete database dump."*

## The batch copy

`BulkCopyFields::copyFields($entities, $fields, $languages, &$context)`:

For each entity → each requested `$langcode` present in `$entity->getTranslationLanguages()` →
`$entity = $entity->getTranslation($langcode)` → each `$field_from => $field_to` where the entity
`hasField` both:

1. `$values = $entity->get($field_from)->getValue();`
2. Per-item `processField()` reconciles date/timestamp representations between source and destination
   storage settings (`processDate()` normalises to storage timezone and `date`/`datetime`/`daterange`
   storage formats).
3. **Entity-reference safety:** if either side is a reference, it errors and skips when
   `target_type`s differ; drops referenced items whose bundle the destination's `target_bundles`
   forbids (warning); and when copying `entity_reference` → `entity_reference_revisions`, loads each
   target and fills `target_revision_id`.
4. `$entity->get($field_to)->setValue($values);`
5. After all fields, for **nodes** calls `setNewRevision()`, then `$entity->save()` and records the id.

`bulkCopyFieldsFinishedCallback()` reports "N fields processed on M entities".

### Field-type helpers

- `processDate($date, $date_type)` → `new \DateTime`, storage timezone, `DATE_STORAGE_FORMAT` for
  `date` else `DATETIME_STORAGE_FORMAT`.
- `processField($value, $field_def_from, $field_def_to)` → converts between plain timestamps and
  datetime strings based on each field's `datetime_type` setting; fills `end_value` for `daterange`.

## Operator walkthrough

1. Go to a Core Bulk Operations listing (e.g. `/admin/content`), tick the rows to change.
2. Choose the action *Bulk Copy \<Label\> Fields* / *Bulk Copy Field Values to Another Field* and
   apply.
3. Step through: languages → source field(s) → destination mapping → confirm ("Copy Fields").
4. Let the batch finish. There is **no undo** — verify on a database copy first.
