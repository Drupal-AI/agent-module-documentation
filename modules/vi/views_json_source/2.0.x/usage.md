<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views JSON Source adds a Views query backend that treats a remote or local JSON document as the base table, so you can build a View whose rows come from a JSON API instead of the database.

---

Views JSON Source extends Views with a `json` base table (`hook_views_data`) whose query plugin, `views_json_source_query`, fetches a JSON document over HTTP (via Guzzle) or from a local path, decodes it, and turns a chosen slice into View rows. The View's *Query settings* expose the JSON source options: `json_file` (URL or `/`-relative path, Drupal tokens like `[site:url]` allowed), `row_apath` (an "apath" pointer to the array of records), `headers` (a JSON string of request headers, themselves token-replaceable), `request_method` (GET or POST), `request_body` (multipart body for POST), `single_payload` (treat the response as one record, not a list), and `show_errors`. The **apath** mini-syntax walks the decoded structure with `/`-separated keys, supports `key=value` to select a matching array element, and `%` as a wildcard filled by a contextual filter. Rows are flattened so nested keys become `parent/child` field keys. It provides Views handlers that all take a `key` (an apath into each row): a field (`views_json_source_field`, with an optional "trusted HTML" raw-render toggle), a filter (`views_json_source_filter`, with operators like =, !=, contains, starts/ends with, regex, length comparisons — evaluated in PHP after transliteration), a sort (`views_json_source_sort`, natural-case comparison), and three argument/contextual-filter handlers (`views_json_source_argument` on a row value, `views_json_source_parameter` to fill an apath `%`, `views_json_source_uri_param` to fill a `%` in the URL). Responses are cached in the default cache bin for `cache_ttl` seconds (module config `views_json_source.settings`, default 86400) and a `PreCacheEvent` lets other code rewrite the payload before caching. The settings form lives at `/admin/config/user-interface/views-json-source-settings` (`views_json_source.settings` route, permission "administer site configuration").

---

- Display data from an external REST/JSON API as a Drupal View.
- Build a listing page whose rows come from a third-party JSON feed instead of nodes.
- Point a View at a local JSON file shipped in your codebase (path starting with `/`).
- Drill into a nested JSON structure using an apath like `data/records`.
- Select one element of a JSON array by matching a key with `nid=2/related`.
- Use a contextual filter to fill a `%` wildcard in the apath (e.g. `%/contents`).
- Use a URL contextual filter to substitute a `%` placeholder in the request URL.
- Insert Drupal tokens such as `[site:url]` into the JSON file URL.
- Send authentication or content-type headers with the request as a JSON string.
- Call a POST endpoint with a multipart request body via `request_method: post`.
- Handle a single-object response (not a list) with the "Response contain single node" option.
- Render a specific JSON key in each row by setting a field's "Key Chooser" apath.
- Output raw HTML from a trusted JSON field via the field's "Trusted HTML" option.
- Filter results in PHP by a JSON key with operators like contains, starts with, or regex.
- Sort rows by a JSON key using natural, case-insensitive comparison.
- Flatten nested objects so `author/name` becomes an addressable field key.
- Cache remote responses for a configurable duration to avoid hammering the API.
- Tune the cache lifetime globally via the `cache_ttl` setting.
- Rewrite or sanitise the JSON payload before it is cached by subscribing to `PreCacheEvent`.
- Expose filters and sorts to visitors on a View of remote JSON data.
- Combine remote JSON rows with Views pagers, fields UI, and styles (table, grid, etc.).
- Show API errors during development with the "Show JSON errors" option.
- Aggregate data from a headless/decoupled service into an existing Drupal theme.
- Prototype against a static JSON fixture, then switch `json_file` to the live API.
