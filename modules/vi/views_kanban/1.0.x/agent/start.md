<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views kanban (views_kanban) — agent index

A Views **style plugin** (`kanban`) that renders a view's results as a drag-and-drop
Kanban board: each row is a card, a chosen status field becomes the columns, and dragging a
card between columns writes the new value back to the entity through an AJAX route. Depends on
core `views`. No global settings page — all configuration lives in the display's Format
settings (config schema `views.style.kanban`).

- Core requirement: `^9 || ^10 || ^11 || ^12`. Package `Views`. License GPL-2.0-or-later.
- Provides no permissions, no drush commands, no new plugin types. Ships a config schema and one
  submodule `views_kanban_demo` (a Task node type + example view; also depends on `field_states`).

Solution docs:
- **Pick "Kanban" as a display format and choose the status/other fields** → [views/kanban-style.md](views/kanban-style.md)
- **Understand how columns are built and how a drag persists the change** → [api/update-state-route.md](api/update-state-route.md)
- **React to a status change (PHP alter hook or the JS event) and optional module integrations** → [hooks/integrations.md](hooks/integrations.md)
- **Override the board / email templates, library, drupalSettings** → [theme/templates.md](theme/templates.md)

Key facts (real machine names):
- Style plugin id `kanban`, class `Drupal\views_kanban\Plugin\views\style\Kanban`, theme hook
  `views_view_kanban`, template `views-view-kanban.html.twig`; preprocess
  `template_preprocess_views_view_kanban()` in `views_kanban.theme.inc`.
- Style option keys: `status_field` (required), `title_field`, `progress_field`, `assign_field`,
  `history_field`, `total_field`, `date_field`, `send_email`, `send_notification`, `dialog_width`,
  `order`, `default`, `disable_dragdrop`, `disable_add`, `show_hide_columns`.
- Drag-save route `update_entity_kanban_state`:
  `/views-kanban/update-state/{view_id}/{display_id}/{entity_id}/{state_value}` →
  `KanbanController::updateState()`; requires permission `access content`; `entity_id` matches `\d+`.
- Alter hook invoked before save: `hook_kanban_change_status($entity, $view, $origin_state)`.
- JS custom event `viewsKanban` dispatched after a successful move (detail: view_id, display_id,
  entityId, state, to, total, point).
- Library `views_kanban/kanban` (`js/kanban.js`, `css/kanban.css`); also attaches
  `core/drupal.dialog.ajax`. drupalSettings flag `views_kanban.permission_drag` gates the client
  drag handles.
- Optional module integrations, all null-guarded: `pwa_firebase`, `notify_widget`,
  `notificationswidget`, `field_states`, `field_permissions`, `paragraphs_table`.
