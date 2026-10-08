<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The copy mechanism — routes, forms, and `copyEntity()`

## Where the "Copy" action appears (`entity_copy_reference.module`)

- `entity_copy_reference_menu_local_tasks_alter()` adds a **Copy** local-task tab on
  `entity.node.edit_form` and `entity.node.canonical`, but only when
  `$node->access('update')` **and** `EntityCopyReference::isCopyEnabled($node)` are both true.
- `entity_copy_reference_entity_operation_alter()` adds a **Copy** operation to node rows under the
  same `$node->access('update')` + `isCopyEnabled()` condition, weighted just after `edit`.
- `entity_copy_reference_help()` provides the module help text.

Both links target route `entity_copy_reference.copy` (`/node/{node}/copy`).

## `EntityCopyReference::isCopyEnabled(Node $node, $user = NULL)`

Returns TRUE only when: config has a `content_types` entry for `$node->bundle()` **and** the user
(default: current user) holds `use entity_copy_reference`. Otherwise FALSE. This governs whether the
tab/operation are shown.

## Confirm form — `EntityCopyReferenceConfirm`

`src/Form/EntityCopyReferenceConfirm.php` (route `entity_copy_reference.copy`, perm
`use entity_copy_reference`, `_admin_route: TRUE`). `buildForm()` loads the `{node}` route
parameter and shows *"Create copy of node <em>@node</em>?"* with a **Create** submit button and a
**Cancel** link back to the node edit form. On submit it instantiates
`new EntityCopyReference()`, calls `copyEntity($node)`, and on success:

- if the new node has a `field_cloned_by` field, sets it to the current user and re-saves;
- shows a status message, logs a notice naming the node and user, and redirects to the new node's
  canonical page. On failure it shows/logs an error and redirects back to the copy route.

Being a `FormBase` POST, the actual creation is CSRF-token protected by core's form API.

## `EntityCopyReference::copyEntity($node, $is_referenced_entity = FALSE)`

The core duplication routine (`src/EntityCopyReference.php`):

1. Loads the node if an id was passed; reads `getConfig()`.
2. `$clone = $node->createDuplicate();`
3. If the clone has a `title` field, prepends the type's `prefix` and appends its `suffix`.
4. If the clone is **not** a paragraph and has a `status` field, sets it **unpublished**
   (paragraphs stay as-is because their container is already unpublished).
5. Sets `created`/`changed` to `time()` and `setOwnerId()` to the current user.
6. For each `reference_fields[<field>]` on the bundle (when the field exists on the node):
   - option `1` (**clone**): `referencedEntities()` are each passed back through
     `copyEntity()` recursively; the duplicated targets replace the field value.
   - option `2` (**clear**): the field is emptied.
   - (option `0`/absent: field left as the duplicate's default, i.e. same references.)
7. `$clone->save()`. On success returns
   `['target_id' => id, 'target_revision_id' => revisionId]`; on exception it logs and returns
   FALSE. If the `gsaml` module is enabled it also calls `GSAML::gsaml_entity_update($clone)`.

Recursion (step 6, option 1) is what makes a copied node's Paragraphs independent of the original.
Only node (and recursively their referenced) entities are handled; the module targets nodes only.

## Operate it

1. Enable the module and grant `use entity_copy_reference` to the roles that should copy content;
   keep `administer entity_copy_reference` (restrict-access) for admins.
2. Configure content types and reference-field handling at
   [../config/settings.md](../config/settings.md).
3. Editors then use the **Copy** tab (node view/edit) or the **Copy** operation (content list),
   confirm, and land on the new unpublished copy.
