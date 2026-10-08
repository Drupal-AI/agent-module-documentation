Submodule of Select2 Boxes that adds a "Select2 boxes" widget option to Better Exposed Filters, so Views exposed filters can render as searchable Select2 dropdowns.

---

`select2_bef` registers a single Better Exposed Filters filter-widget plugin (`@BetterExposedFiltersFilterWidget` id `select2boxes`) that is applicable to any Views filter using an `InOperator` (list-style filters). In the BEF settings for an exposed filter you can select this widget; `exposedFormAlter()` then converts the filter element to a `<select>`, tags it with the `select2-widget` data attributes, attaches the parent module's `select2boxes/widget` library, and honors multiple-value exposure (Select2 chips) versus single-value. For single-value filters it exposes advanced options to limit search-box visibility by a minimum list length. For language/country/address filters it can include flag icons (when the `flags` module is present), building `drupalSettings.flagsClasses`/`flagsFields` maps from the filter options. It depends on both `select2boxes` and `better_exposed_filters`, adds no config schema or permissions of its own, and ships an update hook migrating pre-4.x BEF plugin IDs to the unified `select2boxes` widget id.

---

- Render a Views exposed taxonomy/entity-reference filter as a searchable Select2 dropdown.
- Let site visitors search long option lists in an exposed filter instead of scrolling a plain select.
- Offer multi-value exposed filtering with Select2 tag chips.
- Hide the search box on a single-value exposed filter until the option list reaches a minimum length.
- Configure the minimum list length for showing search on an exposed filter.
- Add country/language flag icons to an exposed language or country filter (with the flags module).
- Improve usability of faceted-style Views with autocomplete-style exposed filters.
- Provide consistent Select2 styling between content forms and exposed filters.
- Convert an existing BEF exposed filter to Select2 without custom code.
- Keep Select2 exposed filters working after upgrading BEF via the bundled plugin-id migration.
- Apply Select2 only to specific exposed filters by choosing the widget per filter in BEF settings.
- Enhance an exposed filter block placed anywhere on the site with Select2 search.
- Reduce mis-selection on large exposed country/language pickers with search + flags.
- Reuse the parent module's CDN/library configuration for exposed-filter Select2 widgets.
- Support AJAX Views: the widget re-adds core Select process/pre-render callbacks so it works with AJAX exposed forms.
