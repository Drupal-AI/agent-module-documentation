# The Change author action

## Plugin
`src/Plugin/Action/ChangeAuthorActionBase.php`, id `change_author_action_base`, label
"Change author", legacy `@Action` annotation with `type = "node"` and
`confirm_form_route_name = "change_author_action.form"`. Implements
`ContainerFactoryPluginInterface`; injects `tempstore.private`, `session_manager`,
`current_user`.

Key methods:
- `access($object, $account, $return_as_object)` → `$object->access('update', $account, …)`.
  Only entities the account can **update** are actionable/selectable.
- `executeMultiple(array $entities)` → builds `[$id => $entity]` and stores them in private
  tempstore collection `change_author_ids` under key `currentUser->id()`. It does **not** change
  anything itself.
- `execute($entity)` → wraps a single entity into `executeMultiple([$entity])`.

Because a `confirm_form_route_name` is declared, core's action-execution redirects the operator
to that route after `executeMultiple()`.

## Shipped action config entities (`config/install/`)
- `system.action.change_author_action_base.yml` — `type: node`, `plugin:
  change_author_action_base` (deps: action, node, change_author_action).
- `system.action.change_media_author_action_base.yml` — `type: media`, same plugin (deps:
  action, media, change_author_action).

To add another entity type, create a `system.action.*` config with `type: {entity_type}` and
`plugin: change_author_action_base` (the plugin's node-typed annotation still resolves through
the action config's `type`). The confirm form reads titles via `$entity->get('title')`, so
entity types without a `title` field may error in step 2.

## Confirm form + batch flow
Route `change_author_action.form` (`change_author_action.routing.yml`):
```
path: /admin/change_author_action
_form: \Drupal\change_author_action\Form\ChangeAuthorActionForm
options: { _admin_route: TRUE }
requirements: { _permission: 'administer users' }
```
`ChangeAuthorActionForm` (multistep via `$this->step`):
- **Step 1** — loads the stashed entities from tempstore `change_author_ids`; renders
  `new_author` as `entity_autocomplete` (`#target_type: user`, `include_anonymous: FALSE`,
  required). Submit rebuilds to step 2.
- **Step 2** — loads the chosen user, shows a confirm title + `<ul>` of the selected items'
  titles. Submit calls `updateFields()`.
- `updateFields()` sets a Batch with operation
  `\Drupal\change_author_action\ChangeAuthorAction::updateFields` over `[$entities, $new_author]`
  and finish callback `changeAuthorActionFinishedCallback`.

## What the batch does (`src/ChangeAuthorAction.php`)
`updateFields($entities, $new_author, &$context)`: for each entity, if
`getOwnerId() != $new_author` → `setOwnerId($new_author)`, `setNewRevision()`, `save()`.
Entities already owned by the target are skipped. (The finished callback's success branch is
commented out; it only messages on failure.)

## Access
- The only place authorship is actually changed is the confirm form, gated by core
  **`administer users`** which has `restrict access: TRUE` — a permission sites are expected to
  grant only to trusted administrators.
- The action plugin additionally restricts selection to entities the operator can `update`.
- A low-privilege user cannot reach the state change: without `administer users` the confirm
  form returns access-denied even if the action was triggered.
- Caveat: the form's `validateForm()` is a stub (`// TODO`); validation relies on
  the required autocomplete. Standard admin operation.
