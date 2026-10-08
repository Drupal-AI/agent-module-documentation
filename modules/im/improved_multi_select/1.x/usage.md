<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Improved Multi Select replaces Drupal's default `<select multiple>` boxes with a JavaScript two-panel "dual list box" widget: an available-options panel, a selected-options panel, add/remove buttons, a search/filter box, and optional up/down re-ordering.

---

The module is entirely front-end: it defines no field type or field widget of its own (the base module). At `hook_page_attachments()` it decides, from a single config object `improved_multi_select.settings`, whether the current page should get the behaviour — either "replace all" (`isall`), a matching request path (`url`), or a set of jQuery `selectors` — and if so attaches the `improved_multi_select/ims` library plus a `drupalSettings.improved_multi_select` payload (the selector list, filter type, button labels, ordering flag, etc.). The JavaScript (`js/improved_multi_select.js`) then transforms each matched `select[multiple]` into the two-panel UI. A single settings form at `/admin/config/user-interface/ims` (route `ims.settings`, permission "administer site configuration") edits every key. Filtering supports six modes (partial/exact/any-words/all-words, each with a partial variant) plus optional JavaScript regular expressions. Two alter hooks let other modules toggle activation per page (`hook_improved_multi_select_activated_alter()`) or rewrite the attached settings (`hook_improved_multi_select_attached_alter()`). Because it only styles the widget, stored field values are unchanged; note that a normal `list`/`entity_reference` field does not persist the visual order on the edit form unless you also use the bundled **IMS Options Widget** submodule.

---

- Replace every multi-select list on a site with a searchable two-panel picker by ticking "Replace all multi-select lists".
- Turn a long taxonomy-term multi-select into a filterable dual list box so editors can find terms quickly.
- Limit the enhancement to specific admin pages via path patterns (e.g. `/node/*/edit`).
- Target only certain fields by CSS/jQuery selector (e.g. `#edit-field-tags`, `select[multiple]`).
- Give content editors a search box over hundreds of options instead of ctrl-clicking a scroll list.
- Let users move chosen items between "available" and "selected" panels with add / remove / add-all / remove-all buttons.
- Allow manual re-ordering of selected items with "Move up" / "Move down" buttons.
- Customise the button glyphs/labels (e.g. use `→`, `←`, `»`, `«`) to match a design.
- Provide exact-match filtering where users must type the option text precisely.
- Provide "any words" or "all words" filtering for loose multi-keyword search.
- Enable partial-word matching so typing "adm" surfaces "administrator".
- Let power users filter with JavaScript regular expressions.
- Set custom placeholder text in the search box (e.g. "Filter roles…").
- Cross-filter optgroup-grouped options together with the search box.
- Reset the filter automatically when a user picks an option group.
- Improve UX of role-assignment multi-selects on the user edit form.
- Improve the "Parent terms" multi-select on taxonomy forms.
- Enhance a Views exposed multi-value filter rendered as a `<select multiple>`.
- Enhance webform multiple-select elements.
- Remove the HTML5 `required` attribute from hidden selects so server-side validation still works.
- Roll the widget out globally without touching individual field configuration.
- Programmatically enable/disable the widget on a page from a custom module via the activation alter hook.
- Inject or rewrite the attached selectors/labels at runtime with the attached-settings alter hook.
- Present a friendlier alternative to core's Chosen/Select2-style pickers using only jQuery + core libraries.
- Keep selected order persisted on the entity by pairing it with the IMS Options Widget submodule.
- Standardise the multi-select experience across content, config and user forms from one settings page.
