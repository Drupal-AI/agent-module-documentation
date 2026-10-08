Views Autocomplete Filters adds an autocomplete (typeahead) dropdown to Views exposed text-field filters, with the suggestions coming from the view's own results.

---

The module extends four existing Views filter handlers — `string`, `combine`, `search_api_text`, and `search_api_fulltext` — by swapping in autocomplete-capable subclasses via `hook_views_plugins_filter_alter()`. When such a filter is exposed and its value renders as a single textfield, a **"Use Autocomplete"** checkbox appears in the exposed-filter options; checking it reveals further settings. As the user types, an AJAX request hits the module's route `views_filters.autocomplete` (`/views-autocomplete-filters/{view_name}/{view_display}/{filter_name}/{view_args}`), which re-executes the view with the typed string as the filter value and returns matching rows as JSON suggestions. You pick which view **field** supplies the suggestion text ("Field with autocomplete results" — the field must be added to the view's field list), so suggestions reflect real, access-checked data already in the view rather than a generic entity lookup. Options let you set a minimum number of characters, a maximum number of items, whether suggestions depend on the other exposed filters (`autocomplete_dependent`), whether contextual/argument filters apply (`autocomplete_contextual`), whether to use raw database values vs. rendered field output for the dropdown and the selected suggestion, and whether to auto-submit the exposed form on selection. Settings persist in the exposed-filter config (schema in `config/schema/views_autocomplete_filters.views.schema.yml`), so they export with the view. The module requires only core Views; it integrates with Search API when that module is present.

---

- Add a typeahead dropdown to an exposed "Title" text filter so editors can quickly find a node by title.
- Autocomplete an exposed author/username filter to jump to all content by a given user.
- Turn a `string` filter with the "Contains" operator into an autocomplete search box.
- Suggest values pulled from the view's own results, so users only see strings that will actually return rows.
- Autocomplete a `combine` filter that searches across several fields at once.
- Add autocomplete to a Search API fulltext exposed filter (`search_api_fulltext`) on an index-backed view.
- Add autocomplete to a Search API text-field filter (`search_api_text`).
- Choose which view field feeds the dropdown suggestions ("Field with autocomplete results").
- Require a minimum number of typed characters before suggestions appear (`autocomplete_min_chars`).
- Cap the number of suggestions returned (`autocomplete_items`; 0 = no limit).
- Make suggestions respect the other currently-set exposed filters (`autocomplete_dependent`).
- Let contextual filters / view arguments narrow the suggestions (`autocomplete_contextual`).
- Auto-submit the exposed form as soon as a suggestion is picked (`autocomplete_autosubmit`).
- Show raw, unformatted database values in the dropdown instead of the rendered field (`autocomplete_raw_dropdown`).
- Insert the raw value (not the rendered markup) into the textfield when a suggestion is chosen (`autocomplete_raw_suggestion`).
- Autocomplete a filter on fields of a referenced entity by adding a Views relationship first.
- Build a "quick find" exposed search page for any content type using a fields-format view.
- Provide a lightweight typeahead search without installing a full search backend.
- Keep suggestions access-aware, since they come from executing the view (which enforces the view's access).
- Deploy autocomplete filter settings between environments as part of the view's configuration export.
- Reduce mistyped filter queries by guiding users to values that exist in the dataset.
- Offer a term/label lookup on a taxonomy-backed exposed filter sourced from real content.
