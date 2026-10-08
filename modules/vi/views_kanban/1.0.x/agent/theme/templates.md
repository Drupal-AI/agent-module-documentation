# Theme: templates, library, drupalSettings

## Theme hooks (`views_kanban_theme()` in `views_kanban.module`)

| Theme hook | Template | Rendered by |
|---|---|---|
| `views_view_kanban` | `templates/views-view-kanban.html.twig` | The board itself (columns + cards). Preprocess `template_preprocess_views_view_kanban()` lives in `views_kanban.theme.inc`. |
| `views_email_kanban` | `templates/views-email-kanban.html.twig` | The notification email body. |

Override either by copying the template into your theme. The board template consumes the
preprocessed variables: `columns` (each with `header`, `color`, `rows`, optional `total`/`add`),
`rows`, `view_id`, `display_id`, `options`, `feedIcons`. Card rows carry `entity_id`, `entity_type`,
`title`, `progress`, `total`, `date`, `assign[]` (name/uid/acronym/avatar), and `view`/`edit` links
(only added when `$entity->access('view'|'update')` passes for the current user). Column colors cycle
through a fixed Bootstrap 5 palette (`primary`, `warning`, `success`, …). The email template
variables: `message`, `author_initial`, `author_avatar`, `type`, `author_name`, `title`,
`assignator`, `btn_text`, `link`.

## Library (`views_kanban.libraries.yml`)

`views_kanban/kanban` — attaches `css/kanban.css` and `js/kanban.js`; dependencies
`core/jquery`, `core/once`, `core/drupal`, `core/drupalSettings`. The preprocess attaches this
library plus `core/drupal.dialog.ajax` (the view/edit/add links open in an AJAX modal whose width is
the `dialog_width` option).

## drupalSettings

`drupalSettings.views_kanban.permission_drag` (bool) — set in the preprocess; `js/kanban.js` only
enables drag-and-drop when it is TRUE (see [views/kanban-style.md](../views/kanban-style.md)).

## JS behaviors (`js/kanban.js`)

- `Drupal.behaviors.Kanban` — drag/drop wiring; on drop, POSTs the move via the update-state route
  (see [api/update-state-route.md](../api/update-state-route.md)) and updates per-column totals; also
  auto-opens a card when the URL carries `?kanbanTicket=<id>`.
- `Drupal.behaviors.kanbanColumnToggle` — per-column show/hide, persisted in `localStorage`
  (`kanbanToggle`), active when the `show_hide_columns` option is on.
- `Drupal.behaviors.kanbanCollapse` — expand/collapse all card bodies.

The build design targets a Bootstrap 5 admin theme (icons use Bootstrap Icons `bi-*` classes).
