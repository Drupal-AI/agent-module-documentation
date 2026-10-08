<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Views style plugin: `collapsible_list` (CollapsibleList)

## Class
`Drupal\views_collapsible_list\Plugin\views\style\CollapsibleList`
`extends Drupal\views\Plugin\views\style\HtmlList`

```
@ViewsStyle(
  id = "collapsible_list",
  title = @Translation("Collapsible list"),
  help = @Translation("Displays rows as an HTML list that can be expanded and collapsed to show more details."),
  theme = "views_view_collapsible_list",
  display_types = {"normal"}
)
```

Because it extends `HtmlList` (the core "HTML list" style), it inherits list wrapping, row
rendering, the `row` plugin requirement (use with `row: fields`), and Views **grouping**.

## Options
- `defineOptions()` adds `collapsible_fields` (default `[]`).
- `buildOptionsForm()`:
  - Overrides `type` to a fixed `value` of `ul` and `wrapper_class` to a fixed `value` of
    `views-collapsible-list` (removes those from the UI to enforce styling).
  - Adds `collapsible_fields`: a `checkboxes` element whose `#options` are
    `$this->view->display_handler->getFieldLabels()` — i.e. the fields currently on the view. Ticked
    fields are the ones hidden/toggled; unticked fields remain always-visible.

Config schema key: `views.style.collapsible_list` (`config/schema/views_collapsible_list.schema.yml`).

## Rendering pipeline
1. `template_preprocess_views_view_collapsible_list()` (in `.module`) runs
   `template_preprocess_views_view_list()` first, so all the standard list variables
   (`rows`, `list`, `title`, `attributes`) are populated.
2. It attaches library `views_collapsible_list/collapse` and builds the JS field list:
   `array_filter(collapsible_fields)` → `.views-field-<Html::cleanCssIdentifier($field)>` →
   `drupalSettings.viewsCollapsibleList.fields`.
3. It sets `section_class = 'btn--' . ($timestamp + rand(1,9999))` — a per-render pseudo-unique
   class so each grouped section's Collapse/Expand-All buttons act only on that section.
4. Template `templates/views-view-collapsible-list.html.twig` emits, per group: the two
   `btn--list-collapse-action` buttons (`btn--collapse-all` / `btn--expand-all`, plus
   `section_class`), an optional `<h3>{{ title }}</h3>` group heading, then `<ul>` of `<li>` rows;
   each `<li>` holds a `<span class="collapse-expand-toggle">` and
   `<div class="views-fields">{{ row.content }}</div>`.

## Client behavior (`js/views-collapsible-list.js`)
- `Drupal.behaviors.collapsibleList`: on attach, for each configured field selector, add class
  `js-collapsible` and `.hide()` it; disable the Collapse-All button initially. Clicking a
  `btn--list-collapse-action` button reads its action/section from its own class list and
  `.show('slow')` / `.hide('slow')`s the section's `.js-collapsible` elements, toggling the two
  buttons' `disabled` state and the `js-expanded` class on the `<li>`s.
- `Drupal.behaviors.collapsibleListItem`: clicking a row's `span.collapse-expand-toggle` toggles the
  row's `.js-collapsible` children and the row's `js-expanded` class, then recomputes the section
  buttons' `disabled` states from how many rows are expanded.
- Library deps: `core/jquery`, `core/drupalSettings`, `core/drupal`.

## How to use
1. Edit a view, add the fields you want.
2. Format → Style → **Collapsible List**.
3. In the style settings, tick the fields under **Collapsible fields** that should be hidden until a
   row is toggled. Leave header-like fields unticked.
4. (Optional) Add a Views grouping field; each group renders its own `<h3>` and its own
   Collapse/Expand-All buttons.

## Limitations / notes
- Disclosure is jQuery `.hide()/.toggle()`, not native `<details>`/`<summary>`; collapsed content
  stays in the DOM (rendered, queried, findable by browser search).
- The per-row trigger is a `<span>`, not a `<button>`/link — not keyboard-focusable and carries no
  `aria-expanded`; no accessibility affordances are added.
- `type` and `wrapper_class` are locked; the list is always a `<ul class="... views-collapsible-list">`.
