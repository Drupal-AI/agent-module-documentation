<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Theming: progress bar & step themes

## Theme hook

`forms_steps_theme()` (`forms_steps.module`) registers **`item_list__forms_steps`** — a variant of
core's `item_list` used to render the progress bar. Variables: `items, title, list_type,
wrapper_attributes, attributes, empty, context`; it reuses `template_preprocess_item_list`.

Template: `templates/item-list--forms-steps.html.twig`. Override it in your theme
(`item-list--forms-steps.html.twig`) to restyle the progress bar. The block builds an ordered (`ol`)
list where each item gets a wrapper class of `previous-step`, `active` (current step, per the progress
step's `routes`), or `next-step`; links are rendered inline as markup.

## Progress-bar block

Place the derivative block **"Forms Steps - Progress bar"** (`forms_steps_progress_bar:<forms_steps
id>`) in a region via Block layout. It renders only on that workflow's step routes
(`FormsStepsProgressBarBlock::build()`), and only shows a progress link when the item has a `link`, the
link is visible for the current step (`link_visibility`), an `instance_id` is present, and — when
`progress_steps_links_saved_only` (optionally `_next`) is on — the linked step has been saved. Output is
uncached (`max-age 0`) and route-context dependent.

## Step / collection theme

Each step and the collection carry a `theme` value (options from `FormsStepsHelper::getThemes()`:
`-1` same as collection, `0` default theme, `1` admin theme). `RouteSubscriber::routes()` translates
this into the route's `_admin_route` option, so a step can render in the admin theme or the front-end
theme independently.
