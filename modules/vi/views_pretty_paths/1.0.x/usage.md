<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Pretty Path rewrites the messy query-string URLs produced by Views exposed filters into clean, human- and SEO-friendly path segments, and rewrites them back on the way in.

---

An admin configures, per row on `/admin/config/views-pretty-path`, a path to rewrite, the view, and the display whose exposed filters should be considered; plus a filter-identifier→name map (e.g. `field_topic_target_id|topics`) and a filter subpath (default `/filter`). An inbound/outbound `PathProcessor` (`ViewsPrettyPathProcessor`) then converts a URL like `/blog?field_topic_target_id[54]=54&keys=x` into `/blog/filter/topics/technology/keywords/x` and, on request, parses those segments back into the query parameters Views expects (via `request->query->replace()`), pointing at the real system path behind the alias. Pluggable **filter handlers** (tagged `views_pretty_paths_filter_handler`) translate each filter's values in both directions: Text (fulltext/combine), Bundle, Date, and Taxonomy (which resolves term names ↔ tids). The module also rewrites pager links, hooks the exposed-form submit to redirect to the pretty URL, and decorates the Redirect module's request subscriber to avoid conflicting redirects.

Operational/security notes: the config form is gated by the *access administration pages* permission. Inbound path segments (unauthenticated request input) are used only as bound query values or in parameterized query-builder conditions — the Taxonomy handler looks up terms with `->condition('name', escapeLike($value), 'LIKE')` and a `vid` condition, with no string concatenation, so there is no SQL injection. Redirects use `TrustedRedirectResponse` built from the configured alias and base URL. Typical setup: enable it (with Redirect, Views, Path alias), add a rewrite row for each view path, define the field-name map and subpath, and confirm the alias exists.

---

- Turn Views exposed-filter query strings into clean URL paths
- Give a blog/listing view SEO-friendly filter URLs
- Map `field_*_target_id` filter identifiers to friendly names
- Configure per-path which view/display filters are rewritten
- Set a custom filter subpath (default `/filter`)
- Rewrite taxonomy term filters using term names in the URL
- Rewrite bundle/content-type filters into path segments
- Rewrite fulltext/keyword search filters into the path
- Rewrite date filters into readable path segments
- Parse pretty paths back into Views query parameters inbound
- Redirect submitted exposed forms to the pretty URL
- Keep pager links working on rewritten URLs
- Support multiple rewritten view paths on one site
- Avoid conflicts with the Redirect module via a decorator
- Add a custom filter handler for an unsupported filter plugin
- Improve shareability/readability of filtered view URLs
- Clean up faceted-listing URLs for indexing
- Remove one view's rewrite config automatically when the view is deleted
- Combine multiple exposed filters into one clean path
