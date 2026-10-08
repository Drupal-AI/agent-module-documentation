<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Submodule of Multiselect Dropdown that registers a Better Exposed Filters (BEF) widget, letting a multi-value Views exposed filter render as a multiselect dropdown.

---

`multiselect_dropdown_bef` provides a `BetterExposedFiltersFilterWidget` plugin (id
`multiselect_dropdown`, class `MultiselectDropdownFilterWidget` extending BEF's
`FilterWidgetBase`). It becomes available in a View's *Exposed Form → Better Exposed Filters*
settings for any exposed filter that allows multiple selections
(`expose.multiple` true); for a `TaxonomyIndexTid` filter the filter type must also be
`select`. `exposedFormAlter()` swaps the exposed filter's form element to
`#type => multiselect_dropdown`, flattens hierarchical options when the filter uses
hierarchy, and maps the widget configuration onto the element's `#label_*`, `#search_*`,
`#modal_breakpoint`, `#default_open`, and `#persist_open` properties, attaching the
`multiselect_dropdown/views` library. Beyond the base label/search settings it adds
close/submit/clear button labels, a modal type (breakpoint/dialog/modal) with breakpoint,
default-open, and "keep open on AJAX submission" (persist-open). It depends on `views`,
`better_exposed_filters` (>=6/>=7), and the parent `multiselect_dropdown`. No permissions,
no Drush, no global config.

---

- Turn a Views exposed taxonomy filter into a searchable multiselect dropdown.
- Let visitors filter a listing by multiple list-field values from one compact control.
- Replace a tall exposed checkboxes/multi-select box with a dropdown dialog.
- Keep the filter dialog open across AJAX exposed-filter refreshes (persist-open).
- Make the exposed filter modal on small screens via the modal breakpoint.
- Add select-all / select-none / submit / clear buttons to an exposed filter.
- Provide an in-dropdown search box for long option lists in a faceted view.
- Flatten hierarchical taxonomy options for display in the exposed filter dropdown.
- Customize all button and status labels for the exposed filter widget.
- Default the exposed filter dropdown to open on page load.
- Give an exposed filter an accessible aria-label and screen-reader instructions.
- Use "No selection = all" semantics (default none-label mirrors the all-label).
- Offer a modern exposed-filter UX without jQuery UI multiselect.
- Apply the widget only to appropriate filters (multiple-select, taxonomy select type).
- Match the exposed filter styling to the theme by overriding the shared template.
