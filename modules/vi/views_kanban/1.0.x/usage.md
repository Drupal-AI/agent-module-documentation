<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views kanban renders a view as a drag-and-drop Kanban board: rows become cards, a chosen status field becomes the columns, and dragging a card between columns writes the new status back to the entity through an AJAX route.

---

The module is a Views **style plugin** (`kanban`) — set a display's Format to "Kanban", switch Show to Fields, add the card fields, and in the format settings map a required **Status field** plus optional title, progress, assignees, history, total, and date fields. Columns are derived from the status field's own vocabulary of values, so the board follows whatever the site already models: a list field's allowed values, a referenced taxonomy vocabulary, a State Machine or Workflow module workflow, Content Moderation states, or a `field_states` state machine. Dragging a card calls the route `/views-kanban/update-state/{view_id}/{display_id}/{entity_id}/{state_value}`, which validates the target value against the field's allowed values, updates the field, optionally appends a change log to a history field, and — when enabled — emails and/or notifies the entity owner and everyone in the assign field (via `pwa_firebase`, `notify_widget`, or `notificationswidget`, all optional). Integrators can implement `hook_kanban_change_status_alter()` to react before the save or listen for the `viewsKanban` DOM event afterwards. Configuration is per-view (schema `views.style.kanban`); there is no global settings page. Core requirement is `^9 || ^10 || ^11 || ^12`, and a `views_kanban_demo` submodule ships a ready-made Task board.

---

- Show a task list as a Kanban board.
- Drag a card between status columns to change its state.
- Build a simple ticket/issue board on Drupal.
- Visualise an editorial or Content Moderation workflow as columns.
- Track applications, leads, or orders through stages.
- Use a list field's allowed values as the columns.
- Use a taxonomy vocabulary as the columns.
- Use a Workflow or State Machine workflow's states as the columns.
- Append a timestamped change history when a card moves.
- Email the owner and assignees when a card changes status.
- Push a notification (Firebase / notify_widget) on a move.
- Show a progress bar per card from a numeric field.
- Sum a points/total field per column in the header.
- Show assignee avatars and initials on each card.
- Hide or show individual columns with a per-column toggle.
- Narrow columns with a Views filter on the status field.
- Open create/view/edit forms in an AJAX modal from the board.
- React to a move server-side with `hook_kanban_change_status_alter()`.
- React to a move client-side via the `viewsKanban` JS event.
- Theme the board or the notification email with a Twig override.
- Give a small team an agile/Scrum project board.
- Replace a spreadsheet-based status tracker.
- Learn the setup from the `views_kanban_demo` submodule.
- Board any entity type (nodes, users, paragraphs) that has a status field.
