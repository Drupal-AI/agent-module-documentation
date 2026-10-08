<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# XPath response rewrite, storage table & settings

## Storage table `beapp_seo_references` (`.install` `hook_schema()`)

Columns: `id` (serial PK), `page_path` (varchar 255, indexed), `xpath_content` (big text),
`created_at`, `updated_at` (datetime). One row per page path; `xpath_content` is a PHP-`serialize()`d
map `xpath_query => ['og_text_val','og_img_src_val','og_href_val','new_text','new_img_src','new_href']`.

Written by `BeAPPAgentUpdateContent::updateContentOnDbXpath()` (upsert via the DB API `insert()` /
`update()` with `->condition('page_path', …)` — parameterized, no string-built SQL). It reads any
existing row with `@unserialize($existing, ['allowed_classes' => false])` (object instantiation
disabled), merges the new override (keeping prior non-empty values), then re-serializes.

## The subscriber `BeAPPContentModifierSubscriber` (`src/EventSubscriber/…`)

Registered as `event_subscriber`, listens on `KernelEvents::RESPONSE` (`onResponse`, priority 0),
constructed with `@database` + `@current_route_match`. On **every** response:

1. Skips non-`text/html` responses.
2. Derives `page_path` from `$_SERVER['REQUEST_URI']`. If the URL carries query params it parses them;
   `?beapp_xpath_mod=false` short-circuits (no rewrite — the QA/validation bypass). Otherwise it
   intersects the query with `whitelisted_params` (via `BeAPPLibrary::buildUrlPathWithWhitelistedParams`)
   to build the lookup key. Trailing slash trimmed (except root).
3. Loads `xpath_content` for that `page_path`; `@unserialize(…, ['allowed_classes' => false])`.
4. Loads the response body into `DOMDocument` (`@loadHTML(..., LIBXML_HTML_NOIMPLIED|LIBXML_HTML_NODEFDTD)`)
   and, for each stored `xpath_query`, takes the first matched node:
   - `img` → `setAttribute('src', new_img_src)` and/or `setAttribute('alt', htmlspecialchars(new_text,…))`.
   - `a` → `setAttribute('href', new_href)` and/or `nodeValue = new_text`.
   - other → `nodeValue = new_text`.
   Each branch first checks the stored `og_*` original still matches the live node (else `continue`).
5. `dom->saveHTML()` replaces the response content.

## Config `brightedge_autopilot_page_publisher.settings`

- `config/install/…settings.yml`: `whitelisted_params: []`.
- `config/schema/…schema.yml`: `config_object` with `whitelisted_params` = sequence of string
  (label "Query Parameter").
- No settings form and no menu link ship. The list is mutated only at runtime by the `wlqp`/`blqp`
  fields of the update-xpath endpoint (see [rest-endpoints.md](rest-endpoints.md)), and read by the
  subscriber and the endpoint to decide which query-string variants map to the same `page_path`.

## Operating notes

- The subscriber re-parses and re-serializes the full HTML of every HTML response when a matching
  `page_path` row exists — a per-request DOM round-trip on those paths.
- Overrides are keyed by URL path, independent of which entity (if any) owns that path, and are applied
  to the rendered output rather than to stored content — so they are invisible to the node/term edit
  forms and survive content edits.
- `htmlspecialchars`/attribute assignment differs by branch: `img@alt` is `htmlspecialchars`-encoded;
  `a@href`, `img@src` and text `nodeValue` are assigned from the stored (already `Html::escape()`d at
  input) values.
