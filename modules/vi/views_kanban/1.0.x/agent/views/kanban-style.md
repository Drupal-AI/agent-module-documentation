# Kanban Views style plugin

Class `Drupal\views_kanban\Plugin\views\style\Kanban` (`#[ViewsStyle(id: "kanban", theme:
"views_view_kanban")]`). `usesFields = TRUE`, `usesRowPlugin = FALSE` — the display must be set to
**Show: Fields**. Config stored under the display's `style.options` (schema `views.style.kanban`).

## Setup

1. Create a View over the entity type you want to board (e.g. Content).
2. Set the display **Format** to **Kanban**.
3. Set **Show** to **Fields** and add the fields to display on cards (title, progress, assignees,
   history, etc.). Fields you only feed to the board (e.g. history) can be marked *Exclude from
   display*.
4. Open the format **Settings** and map the option fields below. The **Status field** is required.

`getCacheMaxAge()` returns `Cache::PERMANENT` and `getCacheTags()` returns `[]` — the board render
is aggressively cached.

## Format settings (`buildOptionsForm`, `defineOptions`)

| Option key | Form control | Default | Purpose |
|---|---|---|---|
| `status_field` | select (required) | `''` | Field whose values become the **columns**. Only status-capable fields are offered (see below). |
| `title_field` | select | `''` | Field used as the card title. |
| `progress_field` | select | `''` | Numeric/list field (0–100) rendered as a progress bar. |
| `assign_field` | select | `''` | User entity-reference field; recipients for email/notification on a move. |
| `history_field` | select | `''` | Unlimited-cardinality field a change log is appended to (see update route doc). |
| `total_field` | select | `''` | Numeric field summed per column and shown in the column header. |
| `date_field` | select | `''` | Date/timestamp field shown on the card (else entity created time). |
| `send_email` | checkbox | `FALSE` | Email owner + assignees when a card moves. |
| `send_notification` | checkbox | `FALSE` | Push a notification via pwa_firebase / notify_widget / notificationswidget. |
| `disable_dragdrop` | checkbox | `FALSE` | Render read-only (no drag handles). |
| `disable_add` | checkbox | `FALSE` | Hide the per-column "Add" link. |
| `show_hide_columns` | checkbox | `FALSE` | Show a per-column toggle-all control (state saved in `localStorage`). |
| `dialog_width` | textfield | `80%` | Width of the modal dialog used for view/edit/add links (number or percent). |

`order` (default `asc`) and `default` also exist in `defineOptions()` but have no form control.

The select **#options** are filtered by the Views field handler `type` of each added field, so a
field only appears in a slot it can serve. Status candidates come from field handler types
`list_default`, `entity_reference_label` (taxonomy), `state_default`, `state_transition`, and
`content_moderation_state` (the last resolved through `getWorkFlowOption()`, which pairs each
`content_moderation` workflow whose `entity_types` intersects the view's `type` filter and stores
it as `moderation_state:<workflow_id>`). Progress candidates: `number_integer`, `list_default`,
`bigint_item_default`. Total: number/decimal/bigint/list. History: `string`, `text_default`,
`double_field_*`, `triples_field_*`. Assign: `entity_reference_label`. Date: `timestamp`,
`datetime_default`, `daterange_default`.

## Set the options via PHP / drush

Options live inside the view config `views.view.<id>` at
`display.<display_id>.display_options.style`. Example (matches `views_kanban_demo`'s view):

```php
$view = \Drupal::entityTypeManager()->getStorage('view')->load('kanban');
$display = &$view->getDisplay('default');
$display['display_options']['style'] = [
  'type' => 'kanban',
  'options' => [
    'status_field'   => 'field_task_status',
    'title_field'    => 'title',
    'progress_field' => 'field_task_progress',
    'history_field'  => 'field_task_history',
    'assign_field'   => 'field_assignors',
    'total_field'    => 'field_task_point',
    'send_email'     => TRUE,
    'send_notification' => TRUE,
    'dialog_width'   => '80%',
    'disable_dragdrop' => FALSE,
  ],
];
$view->save();
```

Or with drush: `drush config:set views.view.kanban display.default.display_options.style.options.status_field field_task_status`.

## How columns are built

`template_preprocess_views_view_kanban()` derives the ordered set of columns from the status
field's definition, choosing the source by field type:

- **List field** — `allowed_values` from the field settings.
- **Taxonomy entity-reference** — terms of the referenced vocabulary
  (`loadTree`/`getQuery()` sorted by `weight`); term id is the column key.
- **Content Moderation** — `status_field` is `moderation_state:<workflow_id>`; states loaded from
  that workflow (`State::labelCallback`).
- **Workflow module** (`workflow` field type) — active `WorkflowState::loadMultiple()` for the
  `workflow_type`, excluding `creation`.
- **State Machine** (`state` field type) — states of the `workflow` plugin.
- **field_states** (`list_states` field type) — transitions handled by the `field_states.transitions`
  service.

Each result row is bucketed into `$columns[<status value>]['rows'][]`; `total_field` values are
summed per column. Columns can be narrowed by a Views filter on the status field: an **is not**
filter hides those values (`hideColumn`), an **is one of** filter shows only those (`showColumn`).

## Drag-and-drop enablement

`permission_drag` (published to `drupalSettings.views_kanban.permission_drag`) is computed in the
preprocess: it is TRUE when the current user holds an edit permission for the bundle
(`edit <bundle> content`, `edit any <bundle> content`, or `edit own <bundle> content`; paragraphs
use `bypass paragraphs type content access`). Setting `disable_dragdrop` forces it FALSE. `js/kanban.js`
only wires the `draggable`/`droppable` handlers when this flag is TRUE, so users without edit
permission see a static board. The actual write is performed by the update-state route — see
[api/update-state-route.md](../api/update-state-route.md).
