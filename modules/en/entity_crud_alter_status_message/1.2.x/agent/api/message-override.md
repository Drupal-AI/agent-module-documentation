<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the status-message override works

All runtime lives in `entity_crud_alter_status_message.module` plus the manager service
(`src/EntityCrudAlterStatusMessageManager.php`). There is no event subscriber — it hooks the entity
form.

## Attaching to the form — `entity_crud_alter_status_message_form_alter()`

`hook_form_alter()` gets the form object; if it is an `EntityFormInterface` **and** the entity's
type id is one of `manager->getValidEntityTypes()` keys (node / taxonomy_term / media), it appends
`entity_crud_alter_status_message_submit_callback` to `$form['actions']['submit']['#submit']`. For a
`taxonomy_term` `default`-operation edit of an existing term it sets
`$form['#operation_override'] = 'edit'` (so a term update is treated as `edit`, not `default`).

## Swapping the message — `entity_crud_alter_status_message_submit_callback()`

After core saves the entity:

1. Reads `entity_type`, `bundle`, and `operation` (using `#operation_override` when set).
2. `manager->getEntityCrudAlterStatusMessage($entity_type, $bundle, $operation)` loads the config
   entity keyed `{type}.{bundle}.{operation}` and returns its `getMessage()` (or `FALSE`).
3. If a rule exists, it computes the **default** core message ending per entity type/operation
   (e.g. node/media `"$label has been created/updated/deleted"`, term
   `"Created new term $label"` / `"Updated term $label"` / `"Deleted term $label"`).
4. It scans the current `status` messages (`messenger()->messagesByType('status')`); for any whose
   `strip_tags()` text contains that default ending, it replaces the message with the configured
   text: first `\Drupal::translation()->translate($configured, ['@label' => …, '@edit_link' => …])`
   (legacy `@label` / `@edit_link` placeholders), then `\Drupal::token()->replace(...)` with the
   saved entity as token data and `['clear' => TRUE]`.
5. It deletes all `status` messages and re-adds the (possibly rewritten) set in order.

Because it matches on the default English message text, the override only fires when core actually
produced that default status message.

## The manager (`EntityCrudAlterStatusMessageManager implements …ManagerInterface`)

- `getValidEntityTypes()` — intersects a hard-coded allow-list
  `['node' => 'Node', 'taxonomy_term' => 'Taxonomy term', 'media' => 'Media']` with the entity
  types actually defined on the site.
- `getCrudMapping($entity_type)` — returns the action→label map used by the form and list builder:
  node/term `['default' => 'Create', 'edit' => 'Update', 'delete' => 'Delete']`; media
  `['add' => 'Create', 'edit' => 'Update', 'delete' => 'Delete']`; otherwise `[]`. (Note the media
  create operation key is `add`, whereas node/term use `default`.)
- `getEntityCrudAlterStatusMessage($entity_type, $bundle, $operation)` — loads
  `storage->load("$entity_type.$bundle.$operation")` and returns `getMessage()` or `FALSE`.

## Notes for callers

- Only **node, taxonomy_term, media** are supported; other entity types are ignored by the hook.
- The rule id must be exactly `{entity_type}.{bundle}.{action}`; the action must match the mapping
  key for that type (`add` for media create, `default` for node/term create, `edit`, `delete`).
- Tokens resolve against the just-saved entity (token type = the entity type id).
