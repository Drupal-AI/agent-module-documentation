# Drag-save route: `update_entity_kanban_state`

The board persists a moved card through one route (`views_kanban.routing.yml`):

```yaml
update_entity_kanban_state:
  path: '/views-kanban/update-state/{view_id}/{display_id}/{entity_id}/{state_value}'
  defaults:
    _controller: '\Drupal\views_kanban\Controller\KanbanController::updateState'
  requirements:
    _permission: 'access content'
    entity_id: \d+
```

- Handler: `KanbanController::updateState($view_id, $display_id, $entity_id, $state_value)` returns a
  `JsonResponse` `{success: bool, message: string}`.
- Permission requirement: `access content`. `entity_id` is constrained to digits.
- The client (`js/kanban.js` `drop` handler) calls it with jQuery `$.ajax` (GET) at
  `Drupal.url('views-kanban/update-state/<view_id>/<display_id>/<entityId>/<stateValue>')` only when
  `currentStatus !== stateValue`.

## What `updateState()` does (in order)

1. Loads the view (`Views::getView($view_id)`), reads the `type` filter to get `entity_type`
   (**falls back to `'user'`** when the filter has no `entity_type`), and reads `status_field` from
   the kanban style options of `$display_id`.
2. Loads the target: `entityTypeManager()->getStorage($entity_type)->load($entity_id)`.
3. Builds the history message and old/new status labels (`getHistoryMessage`, `getStatusName`).
4. If the status field type is `list_states`, applies the transition via the `field_states.transitions`
   service.
5. **Validates** the new value: if `$state_value` is not a key in `getAllowedValues($entity, $status_field)`
   it returns `{success:false, message:"New state @state is not a valid"}` without saving. Allowed
   values come from the field's `allowed_values`, a workflow's states, or the referenced vocabulary's
   terms (same sources as the column builder).
6. Writes the value: `$entity->set($status_field, $state_value)`. For a
   `moderation_state:<workflow_id>` composite key the `<workflow_id>` suffix is stripped first.
7. Appends to `history_field` if configured and present. Value shape depends on the history field
   type: plain string `"<formatted date> <message>"`; `double_field` → `{first: ISO datetime,
   second: message}`; `triples_field` → adds `second: current user display name`, `third: old status`.
8. Invokes the alter hook **before saving**:
   `moduleHandler()->alter('kanban_change_status', $entity, $view, $origin_state)` — see
   [hooks/integrations.md](../hooks/integrations.md).
9. `$entity->save()`.
10. If `send_email` and/or `send_notification` are enabled, emails and/or notifies the entity owner
    plus every uid in `assign_field` (see below).

## Notifications on a move

Recipients = entity owner id + every `target_id` in `assign_field`. When `send_email` is on, each
recipient gets a mail themed by `views_email_kanban` (subject = view title + site name; `Reply-to`
and `Return-Path` are set from the acting user's email; body includes a deep link with query
`kanbanTicket=<entity_id>` so the card opens on arrival). When `send_notification` is on,
`sendNotification()` dispatches through whichever of these modules is enabled: `notify_widget`
(`notify_widget.api`), `notificationswidget` (`notifications_widget.logger`), `pwa_firebase`
(`pwa_firebase.send`). All four controller service injections are null-guarded via
`$container->has(...)`, so the module runs without any of them.

## Response

On success the controller returns `{success:true, message:"<user> change from <old> to <new>"}`; the
JS then dispatches the `viewsKanban` DOM event. On the invalid-value or missing-arg paths it returns
`{success:false, ...}`. The client shows a generic alert on any AJAX error.
