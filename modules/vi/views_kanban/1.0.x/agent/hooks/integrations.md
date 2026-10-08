# Integration points: alter hook, JS event, optional modules

## PHP alter hook — `hook_kanban_change_status`

Invoked in `KanbanController::updateState()` immediately **before** `$entity->save()`:

```php
$this->moduleHandler()->alter('kanban_change_status', $entity, $view, $origin_state);
```

Implement `hook_kanban_change_status_alter()` to react to (or adjust) a move before it is written:

```php
/**
 * @param \Drupal\Core\Entity\EntityInterface $entity  Target entity, already set to the new state.
 * @param \Drupal\views\ViewExecutable        $view    The kanban view.
 * @param string|int                          $origin_state  The value before the change.
 */
function mymodule_kanban_change_status_alter(&$entity, &$view, &$origin_state) {
  // e.g. stamp a "moved by" field, veto by resetting the value, log, etc.
}
```

`$entity` already carries the new status value; `$origin_state` is the previous raw value. The save
happens right after this call.

## JS custom event — `viewsKanban`

After a successful AJAX move, `js/kanban.js` dispatches a `CustomEvent('viewsKanban')` on `document`.
Listen for it (optionally attach your JS with the *Views Attach Library* module):

```js
document.addEventListener("viewsKanban", function (event) {
  // event.detail: { view_id, display_id, entityId, state, to, total, point }
});
```

`state` is the source column value, `to` the destination, `total`/`point` the recomputed column
sums.

## Optional module integrations (all soft dependencies)

| Module | Used for | Guard |
|---|---|---|
| `pwa_firebase` | Firebase push on move | `$container->has('pwa_firebase.send')` |
| `notify_widget` | in-site notification on move | `$container->has('notify_widget.api')` / `moduleExists` |
| `notificationswidget` | logged notification on move | `$container->has('notifications_widget.logger')` / `moduleExists` |
| `field_states` | `list_states` transitions + a state-diagram link on the board | `$container->has('field_states.transitions')` |
| `field_permissions` | broadens who sees the drag/diagram controls | `moduleExists('field_permissions')` |
| `paragraphs_table` | view/edit links + drag support for `paragraph` entities | `moduleExists('paragraphs_table')` |

None are required; absent modules are simply skipped. The `views_kanban_demo` submodule declares a
hard dependency on `field_states` for its example Task board.
