# Configure autocomplete on a Views exposed filter

There is **no admin settings form and no permission** for this module. All configuration
happens per-filter in the Views UI, and is stored in the view's own config (schema:
`config/schema/views_autocomplete_filters.views.schema.yml`), so it exports with the view.

## Which filters can be made autocomplete

On enable, `hook_views_plugins_filter_alter()` swaps these filter handlers for
autocomplete-capable subclasses (all reuse `ViewsAutocompleteFiltersTrait`):

| Views filter id | Handler class | Provided by |
|---|---|---|
| `string` | `ViewsAutocompleteFiltersString` | core Views (basic textfield filter) |
| `combine` | `ViewsAutocompleteFiltersCombine` | core Views (search across multiple fields) |
| `search_api_text` | `ViewsAutocompleteFiltersSearchApiText` | Search API (text field) |
| `search_api_fulltext` | `ViewsAutocompleteFiltersSearchApiFulltext` | Search API (fulltext) |

The **"Use Autocomplete"** checkbox only appears when the filter is **exposed** and its value
renders as a single `textfield`. That means you must pick an operator whose value is a text
input — e.g. **Contains**, **Is equal to**, **Starts with** (the README recommends *Contains*).
Multi-value / range / select operators produce no textfield, so no autocomplete appears.

## Set it up (Views UI)

1. Enable the module: `drush en views_autocomplete_filters -y`.
2. Create/edit a View with **Display format = "Fields"** and add the field you want suggestions
   from (e.g. **Title**). The suggestion field **must** be in the view's field list.
3. Add that same field as a **filter**, mark it **Exposed**, and choose a text operator
   (usually *Contains*).
4. Check **"Use Autocomplete"** — the extra options below appear.
5. Set **"Field with autocomplete results"** to the field added in step 2.
6. Save. The exposed textfield now autocompletes.

For filtering on a referenced entity's field, add a Views **Relationship** first, then add the
field/filter through that relationship.

## Per-filter options (`expose` keys)

Defaults from `ViewsAutocompleteFiltersTrait::defineOptions()`. A key only shows if it exists in
that filter type's config schema.

| Key | Default | Meaning |
|---|---|---|
| `autocomplete_filter` | `0` | Master toggle — "Use Autocomplete". |
| `autocomplete_field` | `''` | View field whose value supplies suggestions (defaults to the same-named field). |
| `autocomplete_min_chars` | `0` | Minimum characters typed before suggestions fire. |
| `autocomplete_items` | `10` | Max suggestions returned (`0` = no limit). |
| `autocomplete_raw_dropdown` | `TRUE` | Show raw DB value in dropdown instead of the rendered field. |
| `autocomplete_raw_suggestion` | `TRUE` | Insert raw value (not rendered markup) into the textfield on select. |
| `autocomplete_dependent` | `FALSE` | Narrow suggestions by the other currently-set exposed filters (loads JS `1-dependent`). |
| `autocomplete_contextual` | `FALSE` | Let contextual filters / view arguments apply to suggestions. |
| `autocomplete_autosubmit` | `FALSE` | Submit the exposed form on selecting a suggestion (loads JS `2-autosubmit`). |

## How suggestions are produced (results-based)

Typing fires an AJAX request to route **`views_filters.autocomplete`**, path
`/views-autocomplete-filters/{view_name}/{view_display}/{filter_name}/{view_args}`, handled by
`ViewsAutocompleteFiltersController::autocomplete()`. It:

- **Access-checks** the view via `::access()` (`_custom_access`) — suggestions honor the view's access.
- Re-executes the view with the typed string `q` set as the filter value; returns matching rows.
- Renders (or reads raw) the chosen `autocomplete_field` per row, case-insensitively keeps rows
  whose value contains `q`, truncates suggestions to 128 chars, de-duplicates, and returns them
  as a JSON array of `{value, label}`.
- Disables view caching for the request and applies the `autocomplete_items` limit via the pager.
- Returns an empty array (no error) if the typed string is shorter than `autocomplete_min_chars`;
  logs to the `views_autocomplete_filters` channel and returns empty if the suggestion field is
  missing/misconfigured.

So suggestions always come from the **view's own result set**, not a generic entity query.
