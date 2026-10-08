<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `views_condition` condition plugin

`Drupal\views_condition\Plugin\Condition\ViewsCondition` — a core Condition plugin
(`@Condition(id = "views_condition", label = "Views", module = "views_condition")`). It extends
`ConditionPluginBase` and appears anywhere Drupal evaluates conditions: block visibility, Layout
Builder section visibility, the Context module, custom `condition` evaluation.

## The three modes

Selected by the `application` config key (a `radios` element titled "Views Condition"):

| `application` | UI label | `evaluate()` returns |
| --- | --- | --- |
| `''` (empty) | Not Restricted | `TRUE` always |
| `all_pages` | All View Pages | `(bool) $route_match->getParameter('view_id')` — TRUE on any view page |
| `specific_views` | Specific View Pages | `!empty($config['views'][$view_id][$display_id])` for the current route |

`view_id` / `display_id` are route parameters Views sets on its **page** display routes
(`view.{view_id}.{display_id}`). On a non-view route both are absent, so `all_pages` and
`specific_views` both evaluate FALSE. Use the condition's built-in **negate** for "everywhere
except view pages".

## Stored configuration shape

```yaml
# e.g. block.block.example -> visibility.views_condition
id: views_condition
negate: false
application: specific_views      # '' | all_pages | specific_views
views:                           # only meaningful when application == specific_views
  frontpage:                     # view_id
    page_1: 1                    # display_id => 1 (checked)
  content:
    page_1: 1
```

Legacy note: an old `view_pages` boolean is migrated in the constructor —
`view_pages: true` becomes `application: all_pages`, then the key is removed.

## Configuration form (`buildConfigurationForm`)

- A `radios` control (`application`) with the three options above,
  `class: views-condition-application`.
- Then, per view, a `details` group (title = view label) shown only when `specific_views` is
  selected (`#states`), containing one **checkbox per display** (title = the display's
  `display_title`).
- The form only lists views that are **enabled** (`$view->status()`) and whose displays are
  `page` displays that are enabled; the `default` (master) display is always excluded.
- `validateConfigurationForm()` clears `views` unless mode is `specific_views`, drops unchecked
  boxes, and errors ("No views selected for condition.") if `specific_views` is chosen with none
  ticked.
- `summary()` renders "Applied to all view pages." or "View Pages - {label}: {displays}; …".
- `calculateDependencies()` returns `module: views` plus `config: views.view.{id}` for each
  selected view, so exported block config stays consistent.

## Targeting a display

`evaluate()` matches by `display_id`, so the display must be a **page** display with its own route
(that is what puts `view_id`/`display_id` on the route). Block/attachment/feed displays only match
if they expose a page route. To make a display selectable, ensure it is an enabled page display in
the view.

## How evaluation works (route-based, no view execution)

`evaluate()` never loads, runs, renders, or queries a view — it only reads the two route parameters
(`view_id`/`display_id`) and compares them to the stored config. No request-derived input flows into
a view argument or query, and it performs no access re-evaluation: the condition is a pure
route-context match, so the view's own page routing and access remain the boundary.
