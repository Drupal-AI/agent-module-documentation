<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Taxonomy radios filter lets site builders render a taxonomy-term Views exposed filter as **radios** (single value) or **checkboxes** (multiple values) instead of the default select dropdown, with a configurable "All / Any" option label.

---

The module provides a Views filter plugin `taxonomy_index_tid_radios` that extends core's
`TaxonomyIndexTid` filter and adds a **Radios/Checkboxes** choice to the filter's "form element" (type)
option. `hook_field_views_data_alter()` automatically swaps the default filter id to
`taxonomy_index_tid_radios` for every `entity_reference` field targeting `taxonomy_term`, so the new
option appears wherever a taxonomy term reference field is exposed as a filter. When the filter is
exposed and set to the radios type, `valueForm()` converts the widget to `radios` (or `checkboxes`
when the exposed filter allows multiple), and a custom **all_label** setting replaces the default
"- Any -"/"&lt;Any&gt;" text with a friendlier label (e.g. "All"); `hook_form_views_exposed_form_alter()`
applies that label at render time. The module carries no configuration UI of its own and no
permissions — you configure it per filter in the Views UI. (This release is a development/pre-release
snapshot: version directory `1.0.x`.)

---

- Expose a taxonomy term filter as radio buttons instead of a select list.
- Expose a taxonomy term filter as checkboxes for multi-select filtering.
- Replace the "- Any -" option with a custom label like "All categories".
- Build a faceted-style category filter without a facets module.
- Let visitors pick a single topic via radios on a listing view.
- Let visitors tick several tags via checkboxes on a search results view.
- Turn a taxonomy entity-reference field filter into a friendlier UI automatically.
- Provide an accessible, always-visible set of filter choices (no dropdown).
- Filter blog posts by a single category with radio buttons.
- Filter a product listing by multiple attribute terms with checkboxes.
- Give exposed filters a clearer default choice label for end users.
- Keep core taxonomy filter behavior (depth, hierarchy) while changing the widget.
- Offer a mobile-friendly tappable filter instead of a small select.
- Apply the radios/checkboxes element to any exposed taxonomy term reference filter.
- Present event filters (e.g. event type) as radio buttons.
- Present region/location term filters as checkboxes.
- Standardize taxonomy filter presentation across multiple views.
- Improve scannability of a small, fixed set of filter terms.
- Combine with an AJAX view for instant radio/checkbox filtering.
- Localize the "All" label via the exposed form.
