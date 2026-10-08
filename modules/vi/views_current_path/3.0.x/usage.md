<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Current Path adds a single "Global: Current path" field to Views that outputs the path (or URL, or query string) of the page the view is being rendered on, with per-field options controlling the output style.

---

The module implements `hook_views_data_alter()` to register one global field handler, `current_path` (class `CurrentPath` extending `FieldPluginBase`). The field runs no database query; on render it reads the current path from the `path.current` service (and, for some styles, `\Drupal::request()->getRequestUri()` / `$_SERVER['QUERY_STRING']`). An "Output style" radio picks one of seven formats: raw internal path (`node/215`), raw relative/absolute URL, alias internal/relative/absolute URL, or query-string-only. For the alias-relative style, a "Query string handling" option can leave, remove, replace, or concatenate the existing query string — useful when the field feeds a Views rewrite/link so a built URL keeps its parameters. The query-string-only style adds parameter processing: an allow-list filter (optionally requiring a value with a trailing `=`), renaming (`old|new`), trailing-space trimming, and lower-casing. Output is emitted as `#markup` with appropriate `url.query_args` cache contexts, plus an optional per-user cache context. There is no admin settings page, no permissions, and no Drush — everything is configured on the field itself inside a view. A config schema (`views.field.views_current_path`) covers all stored options.

---

- Print the current internal path (e.g. `node/215`) as a column or header/footer in a view.
- Output the current page as a raw relative URL including the base path.
- Output the current page as a raw absolute URL (scheme + host + path).
- Print the URL alias of the current page instead of the internal path.
- Print an absolute aliased URL for the current page.
- Emit only the current query string (e.g. `nid=357&tid=271`).
- Feed a Views field rewrite/link so a generated link points back at the current page.
- Build a "back to this page" or self-referencing link inside a view.
- Preserve the existing query string when constructing a rewritten link (concatenate mode).
- Strip the query string from the current path for a clean canonical link.
- Replace the current query string with parameters supplied through a path rewrite.
- Keep only an allow-listed set of query parameters when echoing the query string.
- Require a query parameter to have a value before keeping it (trailing `=` in the filter).
- Rename query parameters on output (e.g. `tid|term`) for a downstream link.
- Trim trailing whitespace from query parameter values.
- Lower-case query parameter values for consistent links.
- Use the current path token (`[current_path]`) inside a Views rewrite template.
- Add per-user caching for a view whose current-path output varies by user.
- Show contextual breadcrumbs or debugging output of the request path in a view.
- Drive conditional Views logic/rewrites off the current URL without custom code.
- Expose the current path to a Views-based block placed across many pages.
- Provide a copy-the-URL field on a page-embedded view.
