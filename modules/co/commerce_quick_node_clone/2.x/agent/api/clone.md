<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Clone route, access model, and duplication logic

## Install / enable

`drush en commerce_quick_node_clone`. Requires `node`, `commerce`, `commerce_product`. Nothing
else is required; `group`/`gnode` and `paragraphs` are used only when present. After enable,
each `commerce_product` gains a `Clone` local task and a `quick_clone` operation, once the
current user holds the relevant `clone <type> content` permission (see permissions below).

## Route (`commerce_quick_node_clone.routing.yml`)

- `commerce_quick_node_clone.node.quick_clone` — path `/clone/{node}/edit`, method GET.
  - `_controller`: `QuickNodeCloneNodeController::cloneNode`, `_title`: "Clone product".
  - `_custom_access`: `QuickNodeCloneNodeAccess::cloneNode`.
  - `options._admin_route: TRUE`; `{node}` param `type: entity:commerce_product` (upcast to a
    loaded `Product`). Despite the `node` param name, this is a **commerce_product** id.

Entry points to that route: the `quick_clone` entity operation and the `Clone` task
(`links.task.yml`, `base_route: entity.commerce_product.canonical`), both built with a
`\Drupal::destination()` query so the editor returns to where they started after saving.

## Permissions

- Static: `Administer Quick Node Clone Settings` (title "Commerce Quick Node Clone Settings") —
  gates only the settings form.
- Dynamic (per product type): `CommerceQuickNodeClonePermissions::cloneTypePermissions()`
  (referenced from `commerce_quick_node_clone.permissions.yml` via `permission_callbacks`)
  iterates `ProductType::loadMultiple()` and emits `clone <type_id> content` for each product
  type.

## Access model — `_commerce_quick_node_clone_has_clone_permission()` (in the `.module`)

Both the access callback (`QuickNodeCloneNodeAccess::cloneNode()`) and the operation/task
visibility go through this helper. For the loaded product it requires:

1. `\Drupal::currentUser()->hasPermission("clone {$bundle} content")`, AND
2. create access to that bundle:
   - If `gnode` is enabled and the product belongs to one or more groups, it loads the group
     relationships (`GroupContent`/`GroupRelationship::loadByEntity()` via
     `_commerce_quick_node_clone_get_group_entity_class()`) and returns TRUE if the user has
     `entityCreateAccess()` on any of those groups (checked through
     `group_relation_type.manager`).
   - Otherwise (no gnode, or product has no groups) it returns TRUE when
     `$node->access('create')` is TRUE.

`QuickNodeCloneNodeAccess::cloneNode()` wraps the boolean in
`AccessResult::allowed()`/`forbidden()`, adds `$node` as a cacheable dependency, and marks the
result `cachePerPermissions()` + `cachePerUser()`. If the param is a scalar/unloadable id it
returns `forbidden()`.

## Clone logic — `QuickNodeCloneNodeController::cloneNode(Product $node)`

The controller extends core `NodeController` (constructor also injects `current_user`,
`module_handler`, `entity_type.manager`, `config.factory`, `entity.form_builder`). It:

1. `$duplicate = $node->createDuplicate();` then overrides `uid` → current user id and
   `created` + `changed` → `\Drupal::time()->getCurrentTime()`.
2. Collects the source product's groups (when `gnode` is present) — stored but not re-attached
   in this code path.
3. Computes the destination bundle's **default** `status` value from a freshly created product
   of the same bundle (used only when `clone_status` is off).
4. For each translation language of the duplicate:
   - `cloneParagraphs()` deep-clones paragraph fields (see below).
   - Invokes `hook_cloned_node_alter($translated_node, $node)` via `moduleHandler->alter()`.
   - Prefixes the title with `text_to_prepend_to_title` (+ a space) when set.
   - If `clone_status` is falsy, sets the entity's `published` key to the bundle default status.
   - `setTitle()` with the (prefixed) title.
5. Adds a status message "Review and update this cloned product before saving." and **returns
   `entityFormBuilder->getForm($duplicate, 'default')`** — the standard product edit form,
   pre-populated. **No entity is saved here.** The product is created only when the editor
   submits that form (its own POST + CSRF). If `$node` is empty it throws `NotFoundHttpException`.

### Paragraph deep-clone — `cloneParagraphs(Product $node)`

Iterates field definitions; for any field whose storage `target_type == 'paragraph'` and is
non-empty, it replaces each referenced paragraph with `->createDuplicate()` so the clone owns
its own paragraph entities (avoids two products sharing one paragraph). For each duplicated
paragraph's fields it consults `excludeParagraphField($field_name, $bundle)` and `unset()`s
excluded fields, then fires `hook_cloned_node_paragraph_field_alter($paragraph, $field_name,
$settings)`.

- `excludeParagraphField()` reads config `exclude.paragraph.<bundle>` (a list of field names) and
  returns whether the field is in it.
- **Variations are not touched here** (they are `entity_reference` to
  `commerce_product_variation`, not `paragraph`), so the duplicate initially references the same
  variation entities; the editor sets SKUs/variations on the pre-filled form before saving.

### Config accessor — `getConfigSettings($key)`

Reads `commerce_quick_node_clone.settings:<key>`; if NULL, falls back to the legacy
`quick_node_clone.settings:<key>`. Used for `text_to_prepend_to_title`, `clone_status`, and the
`exclude.paragraph.<bundle>` lookups.

## Hooks other modules can implement

- `hook_cloned_node_alter(ContentEntityInterface &$clone, ContentEntityInterface $original)` —
  adjust the duplicate before the form renders.
- `hook_cloned_node_paragraph_field_alter($paragraph, string $field_name, array $field_settings)`
  — adjust each duplicated paragraph field.
