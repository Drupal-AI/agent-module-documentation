Choices.js integrates the vanilla [Choices.js](https://github.com/Choices-js/Choices) library into Drupal, turning plain `<select>` elements into searchable, tag-style dropdowns either globally (by CSS selector) or per-field via a widget.

---

The module offers two independent integration modes controlled from one settings page (`/admin/config/user-interface/choices`, route `choices.admin`, permission `administer site configuration`). The **global** mode (`enable_globally`) attaches Choices to every `<select>` matching a configurable list of CSS selectors (default `select[multiple]`), scoped to admin pages, front-end pages, or both via the `include` radio. It is wired through `hook_element_info_alter()` adding a `#pre_render` (`ChoicesCallbacks::preRender`) to the `select` element, which attaches the `choices/global` library and passes the selectors + a JSON options object through `drupalSettings`. The **field widget** mode provides a `choices_widget` field widget (extends core `OptionsSelectWidget`) usable on `entity_reference`, `list_integer`, `list_float` and `list_string` fields from *Manage form display*; each widget instance can carry its own JSON options that deep-merge over the global ones (widget > global > library defaults). The Choices library loads locally from `/libraries/choices.js/...` by default; enabling **Use CDN** (`use_cdn`) swaps to jsDelivr via `hook_library_info_alter()`. Configuration options are entered as a JSON object and validated with `justinrainbow/json-schema` (only that it is a valid JSON object; individual keys are not checked). A submodule, `choices_facets`, exposes Choices as a Facets widget.

---

- Turn a long multi-value `<select>` into a searchable, tag-style dropdown.
- Apply Choices site-wide to all `select[multiple]` elements with the default global config.
- Restrict the global enhancement to a specific set of selects via custom CSS selectors (e.g. `select#edit-type, .choices-select`).
- Enable Choices only on admin pages (e.g. to improve back-end UX without touching the theme).
- Enable Choices only on front-end pages, leaving the admin UI untouched.
- Use Choices as a field widget on an entity-reference field so only that field is enhanced.
- Use Choices as a field widget on List (text/integer/float) fields.
- Allow content editors to type-to-filter long option lists.
- Pass custom Choices options (e.g. `removeItemButton`, `searchFields`, `delimiter`) as JSON.
- Override global Choices options for one specific field via the widget's own JSON options.
- Serve the Choices library from the jsDelivr CDN instead of hosting it locally.
- Self-host the Choices library under `/libraries/choices.js/` to avoid a CDN dependency.
- Provide a lightweight, jQuery-free alternative to Select2/Chosen.
- Add "add item" tag-input behaviour to a multi-select.
- Validate that custom Choices options entered in the admin form are a well-formed JSON object.
- Give a Facets exposed filter a Choices-powered dropdown (via `choices_facets`).
- Standardise select styling across a site with one global setting.
- Configure whether HTML is allowed in option labels via the `allowHTML` Choices option.
- Deep-merge per-field JSON options over global options for fine-grained control.
- Improve keyboard accessibility of large option lists.
- Apply Choices to a custom form's select by matching its selector in the global CSS-selector list.
