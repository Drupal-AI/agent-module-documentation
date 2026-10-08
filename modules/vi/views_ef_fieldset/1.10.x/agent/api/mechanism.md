# How it works (mechanism)

Two moving parts: a Views display-extender plugin (the config surface) and a form alter (the
runtime rebuild), plus a helper that turns the stored flat list into a render tree.

## Display extender plugin

`src/Plugin/views/display_extender/ViewsEFFieldset.php`, id `views_ef_fieldset`, extends
`DefaultDisplayExtender`. `buildOptionsForm()` only acts when `$form_state->get('section') === 'exposed_form_options'`:
it enumerates the display's exposed filters (`$this->view->getHandlers('filter')`), their operators
(when `use_operator`), exposed `sort_by`/`sort_order`, and the Submit/Reset buttons, seeds a set of
containers, and renders a `#type => table` with `#tabledrag` (match parent / depth / order) so the
admin can nest and weight items. `submitOptionsForm()` folds each row's hidden `item` fields back up
and stores everything under `$this->options['views_ef_fieldset']`. Because the module's install hook
registers the plugin in `views.settings` `display_extenders`, every view carries these options.

## Runtime alter

`views_ef_fieldset.module` implements `hook_form_views_exposed_form_alter()`:

1. Reads `$display['display_options']['display_extenders']['views_ef_fieldset']['views_ef_fieldset']`.
2. If `enabled` is truthy and `options.sort` exists, attaches the `views_ef_fieldset/views_ef_fieldset.styling`
   library and constructs `new ViewsEFFieldsetData($options['options']['sort'], $form)`.
3. Sets `$form['filters']['children'] = $data->treetofapi()` and `$form['#info']['views_ef_fieldset']['value'] = 'filters'`.

So the grouping is applied to the live exposed form only; the stored view results are unaffected.

## ViewsEFFieldsetData (src/ViewsEFFieldsetData.php)

- `parseTree()` / `buildTreeData()` — turn the flat `sort` list into a nested tree using each item's
  `pid`, sorting siblings by `weight`.
- `treetofapi()` / `recursivetreetofapi()` — walk the tree and, per item `type`:
  - `filter` → move `$form[<field>]` (and its `<field>_op` / `<field>_wrapper` operator element) into
    the target container via `moveFormElement()`, carrying over label/description and weight.
  - `sort` → move the exposed `sort_by` / `sort_order` element.
  - `buttons` → move `$form['actions'][submit|reset]` into the container (and hide the original with
    inline `display:none`).
  - `container` with children → emit a render element of `#type` = the item's `container_type`
    (`container` / `details` / `vertical_tabs`) with `#title`, `#description`, `#open`, and CSS classes
    `views-ef-fieldset-container` + `views-ef-fieldset-<id>`, then recurse into its children.
- `buildFlat()` (used by the admin table) flattens the tree with `RecursiveIteratorIterator` and an
  `ArrayDataItemIterator` to compute each row's `depth` for indentation.

## Notes for an agent

- No plugin *type* is defined; this **implements** the core Views `display_extender` plugin type.
- Nothing renders unless `enabled` is TRUE **and** `options.sort` places elements into containers.
- Editing the view config directly is equivalent to using the UI table; keep `pid`/`weight`/`type`
  consistent, and remember weights/depths are stored as strings.
