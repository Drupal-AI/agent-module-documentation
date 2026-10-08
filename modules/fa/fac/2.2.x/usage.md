Fast Autocomplete (fac) shows IMDB-like suggestions below any text input, served from pre-generated JSON files in the public files directory so the browser gets them fast without a full Drupal bootstrap.

---

You create one or more **Fast Autocomplete configuration** config entities (`fac_config`) at `/admin/config/search/fac`, each targeting one or more inputs by jQuery selector (e.g. `input.form-search`). A configuration picks a **search plugin** — `BasicTitleSearch` (a `LIKE` query on published node titles) or `SearchApiSearch` (queries a Search API index) — plus behaviour options (result count, min/max key length, breakpoint, empty-focus HTML, "view all results" link) and a **view mode per entity type** used to render each suggestion. On every page a JS behaviour (`js/jquery.fastautocomplete.js`) watches the configured inputs; on keystrokes it requests `public://fac-json/{config}/{lang}/{hash}/{key}.json`. If that static file exists the webserver returns it directly; if not, Drupal's `fac.json` route (`FacController::generateJson`) bootstraps, runs the search, writes the JSON file for next time, and returns it. Results are cached publicly, so by default the search runs **as the anonymous user** ("Perform search as anonymous user only", default on) to avoid leaking access-restricted content; the file path also embeds a rotating **role-based HMAC hash** (`HashService`) so users only ever hit cache generated for their own role set. Optional cron cleanup deletes expired JSON files, and the hash key is rotated on `key_interval` (default one week) whenever any config runs non-anonymous. Extend it with your own search backends via the `fac_search` plugin type, and alter the empty-focus content with `hook_fac_empty_result_alter()`. A Drush command `fac:cache-clear` purges the JSON files.

---

- Add IMDB-style autocomplete suggestions to a custom search box by jQuery selector.
- Suggest published nodes by a `LIKE` match on their title (BasicTitleSearch plugin).
- Drive suggestions from a Search API index instead (SearchApiSearch plugin).
- Render each suggestion using a chosen view mode so results look like teasers, not plain text.
- Limit suggestions per entity type (e.g. only Article and Page) via the BasicTitleSearch bundle filter.
- Filter suggestions by the current interface language.
- Serve suggestions as fast static JSON files without bootstrapping Drupal on cache hits.
- Show custom "quick links" HTML when the input is focused but empty (empty-result content).
- Add a "view all results" link below suggestions once a threshold count is reached.
- Only enable autocomplete above a minimum viewport width (breakpoint) for mobile-friendly behaviour.
- Constrain when a query fires with minimum and maximum key length.
- Highlight the typed keywords inside suggestions using mark.js (CDN or local copy).
- Run suggestion queries as the anonymous user to prevent leaking restricted content into public cache.
- Optionally run queries as the current user, mitigated by a rotating role-based hash in the file path.
- Periodically clean up cached JSON files on cron with a configurable expiry (e.g. "-1 day").
- Manually purge all cached JSON for a configuration from the operations dropdown.
- Purge cached JSON for all or specific configurations from the CLI with `drush fac:cache-clear`.
- Rotate the URL hash key on a schedule to reduce information-exposure risk for non-anonymous search.
- Add a custom search backend (e.g. Solr, an external API) by implementing the `fac_search` plugin type.
- Show a throbber while a request is in flight using the `fac:requestStart` / `fac:requestEnd` JS events.
- Provide multiple independent autocomplete configurations, each on different inputs.
- Exclude the `fac-json` directory from Stage File Proxy so cached files are not proxied from production.
- Append suggestions to a specific element (result location) rather than the input's form.
- Give editors a maintainable "empty results" menu by loading it in `hook_fac_empty_result_alter()`.
