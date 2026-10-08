<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTMX Debugging (htmx_debug) — agent index

Developer-only submodule of **htmx**. Enabling it makes HTMX easier to debug; there is nothing
to configure. No config, no permissions, no services, no routes.

What it does (all via hooks — cheaper to read here than the source):
- `htmx_debug_library_info_alter()` — removes core's minified `htmx.min.js` from `core/htmx`
  and substitutes the **unminified `htmx.js`** (`minified: false`).
- `htmx_debug_page_attachments_alter()` — attaches the `htmx_debug/debug` library
  (`js/htmx/debug.js`, the HTMX **debug extension**).
- `htmx_debug_preprocess_html()` — adds `data-hx-ext="debug"` to `<html>` so every HTMX event
  is **logged to the browser console** page-wide.
- All three **skip HTMX requests** (when the `HX-Request` header is present) so partial
  responses stay clean.

Usage: `drush en htmx_debug` in development; uninstall (`drush pmu htmx_debug`) in production.
Depends on `htmx`. Library provided: `htmx_debug/debug` (version 2.0.1).
