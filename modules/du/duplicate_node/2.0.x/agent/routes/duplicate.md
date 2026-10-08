<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Duplicate route, controller & access

## Route (`duplicate_node.routing.yml`)

`duplicate_node.node.duplicate_node`
- path: `/duplicate/{node}/duplicate_node` (`{node}` is an `entity:node` upcast param).
- `_controller`: `DuplicateNodeController::duplicateNode`
- `_title_callback`: `DuplicateNodeController::duplicatePageTitle`
- `_custom_access`: `DuplicateNodeAccess::duplicateNode`
- options: `_admin_route: TRUE`.

Entry points to this route: the Duplicate **local task tab** and **contextual link**
(`duplicate_node.links.task.yml`, `duplicate_node.links.contextual.yml`, both `base_route:
entity.node.canonical`), and the node **operation** `duplicate_node` added by
`duplicate_node_entity_operation()` in `.module` (weight 100) — the operation is only added when
`_duplicate_node_has_duplicate_permission($entity)` is TRUE for that node.

## Controller flow (`src/Controller/DuplicateNodeController.php`)

`DuplicateNodeController` extends core `NodeController`. `duplicateNode(Node $node)`:
- If `$node` is empty → `NotFoundHttpException`.
- Otherwise returns `$this->entityFormBuilder()->getForm($node, 'duplicate_node')`, where
  `entityFormBuilder()` is overridden to return the `duplicate_node.entity.form_builder` service
  (`DuplicateNodeEntityFormBuilder`).

So the route **renders a normal node edit form** pre-populated from a duplicate of the source
node (built in-memory by the form-builder service — see
[api/internals.md](../api/internals.md)). The new node is **persisted only when the editor
submits that form** (POST); saving is handled by `DuplicateNodeForm::save()`. Requesting the
route does not by itself create/save a node.

`duplicatePageTitle(Node $node)` returns the `prefix_for_node_title` config value (plus a space)
prepended to the source node's title, used as the page title.

## Access model (`src/Controller/DuplicateNodeAccess.php`)

`DuplicateNodeAccess::duplicateNode($account, $node)` loads the node and returns
`AccessResult::allowed()`/`forbidden()` based on the shared helper
`_duplicate_node_has_duplicate_permission()` (in `.module`), then adds the node as a cacheable
dependency. Access is granted when the current user:
- holds the per-bundle permission **`duplicate {bundle} content`** (generated per content type,
  see permissions below), **and**
- has **create access** for that node bundle (`$node->access('create')`); or, when the **Group**
  module (`gnode`) is enabled and the node belongs to group(s), has group create access for the
  relevant group relationship (supports Group 1.x via `GroupContent` and 2.x/3.x via
  `GroupRelationship` + `group_relation_type.manager`).

The same access check backs the Views duplicate-link field and the entity operation, so a
Duplicate link/tab appears only where this check passes.

## Permissions (`duplicate_node.permissions.yml`, `src/DuplicateNodePermissions.php`)

- Static: `Administer Duplicate Node Settings` — required by both settings-form routes.
- Dynamic: `permission_callbacks` → `DuplicateNodePermissions::duplicateTypePermissions()`
  emits one `duplicate {type_id} content` permission per node type (title
  "`%type: duplicate content`"), enumerated from `NodeType::loadMultiple()`.
