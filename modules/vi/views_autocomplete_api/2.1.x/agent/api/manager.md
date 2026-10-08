<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ViewsAutocompleteApiManager service

`src/Service/ViewsAutocompleteApiManager.php`, service id `views_autocomplete_api.manager`.
Constructor args: `@views.executable` (`ViewExecutableFactory`), `@current_user`, `@renderer`,
`@config.factory`. Logs to channel `views_auto_complete_api`. This is where the View is run and its
rows are turned into autocomplete suggestions.

## Public helpers used by the controller
- `getViewsDisplayId($display_id, $count_view)` → array of display ids. Non-empty `$display_id` is
  `explode(',')`'d (warns if the count ≠ number of Views); empty → an array of `'default'` × count.
- `prepareArgumentViews($views_arguments, $count_view)` → array of per-View arg arrays. NOTE the guard is
  `if (!empty($views_arguments) || trim($views_arguments) == "") return [];` — as written this returns
  **early for a non-empty argument string too**, so contextual args are effectively passed through only in
  narrow cases; `,` splits per View and `&` splits args within a View.

## `executeViews(View $view, $display_id, $search, array &$view_data, array $args = [])`
1. `initViews()` — `viewsExecute->get($view)`, `setDisplay($display_id)`, an **access check**
   `if (!$view_execute->access($display_id) && !currentUser->hasPermission('administer views'))` (logs and
   returns FALSE on denial), then `setArguments($args)` if any. So the **View's own access plugin gates the
   results**; a user with `administer views` bypasses that check.
2. `setFilter()` — reads the display's `filters` option; for every handler with `exposed === TRUE` and a
   non-empty `expose.identifier`, sets `$options['value'] = $search` and writes them back with
   `overrideOption('filters', …)`. This is how the typed text drives the exposed filters (values flow
   through the Views filter handlers, which build parameterized queries).
3. `executeDisplay()`, then reads `$view_execute->result` × `$view_execute->field` and calls the style
   plugin's `getField($index, $field_name)` to render every field per row into `$rendered_fields`.
4. `getData()` maps each row to a suggestion; if it produced data, header/footer special rows are prepended/
   appended; otherwise an empty-area special row is emitted. Results are `array_merge`d into `$view_data`.

## Row → suggestion mapping — `getData(array $rendered_fields, $search)`
- `value` = `strip_tags()` of the **second-to-last** field (`$row_values[count($row)-2]`) — HTML stripped
  because this is injected into the input on selection.
- `label` = the **last** field (`$row_values[$count-1]`) when the View has >1 field, else the same field.
- If config `views_autocomplete_api.settings:highlight` is TRUE, `label` is passed through `highlightStr()`.

## Highlight & special rows
- `highlightStr($haystack, $needle)` builds pattern `"/(?![^<]*>)$needle+/i"` and `preg_replace`s the match
  with the `views_autocomplete_api_highlight` themed `<span>{{ search_word }}</span>`. It also transliterates
  the needle via `removeAccents()` (htmlentities-based) and adds a second pattern when they differ.
- `formatSpecialRow($type, array $data_views, $search)` renders a display area (`header`/`footer`/`empty`),
  substitutes the literal `[autocomplete]` token with the current search, and themes it via
  `views_autocomplete_api_special_row` (`templates/views-autocomplete-api-special-row.html.twig`).

## Config dependency
Only reads `views_autocomplete_api.settings:highlight` (see config/settings.md). No entities are written,
no HTTP client, no direct SQL — queries are built by the Views executable/filter handlers.
