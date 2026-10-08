<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block & widget configuration

## Set the facet widget
Facets Form has no settings page. Each facet you want in the form must use a Facets Form widget.
On the facet edit form (Facets admin), set the **Widget** to one of:
- **Dropdown (inside form)** — `facets_form_dropdown`
- **Checkboxes (inside form)** — `facets_form_checkbox`
- (submodules add `facets_form_date_range`, `facets_form_date_range_extended`,
  `facets_form_fulltext`)

Only facets whose widget implements `FacetsFormWidgetInterface` are "eligible" and appear in the form.

### Dropdown widget config (`facet.widget.config.facets_form_dropdown`)
- `default_option_label` (textfield, default `Choose`) — placeholder option, used when the facet is
  "show only one result" (single-select).
- `child_items_prefix` (textfield, maxlength 1, default `-`) — prefix repeated per nesting level for
  hierarchical options.
- `disabled_on_empty` (checkbox, default FALSE) — keep the widget but disabled when there are no
  results (else the widget build is empty).
- Renders a `<select>`; `#multiple` unless the facet is "show only one result".

### Checkboxes widget config (`facet.widget.config.facets_form_checkbox`)
- `disabled_on_empty` (checkbox, default FALSE).
- `indent_class` (textfield, default `indented`) — CSS class wrapped around each checkbox once per
  depth level (`indentCheckboxes` after-build).
- Renders a `checkboxes` element inside a fieldset.

Both inherit the Facets default widget config (e.g. `show_numbers`) and the shared
`facets_form_default_config` (`disabled_on_empty`).

## Place & configure the block
The `facets_form` block is derived per facets source. Place **"Facet form: <source>"** (category
*Facets*) via Block layout or Layout Builder. Block form (`FacetsFormBlock::blockForm`):
- **Limit to facets** (`facets`) — checkboxes of the source's eligible facets; leave empty to expose
  all. Stored as an array of facet ids.
- **Submit button** (`submit_label`, required) → `button.label.submit`.
- **Reset button** (`reset_label`, required) → `button.label.reset`.

Block config schema `block.settings.facets_form:*:*`:
```yaml
button: { label: { submit: <label>, reset: <label> } }
facets: [ <facet_id>, ... ]   # empty = all eligible facets
```
The block adds config dependencies on the facets it exposes (`calculateDependencies`). The
`facets_form_live_total` submodule adds a `live_total` boolean to this schema.

## Submit / reset behavior (`FacetsForm`)
- On submit, each widget's `prepareValueForUrl()` produces active filter values; if any, the
  Facets URL generator (`facets.utility.url_generator`) builds the filtered URL and the form
  redirects to it. With no active filters, it redirects to the current URL with the `f` query
  parameter removed.
- Reset is a link (styled as a button) to the current route with `f` stripped (non-filter query
  args like paging/sort are preserved).
- The form is cache-varied by `url.query_args`; each facet build is added as a cacheable dependency.
