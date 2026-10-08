<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Exposed input token (views_exposed_input_token) — agent index

Adds one global Views token, `[view:exposed-input]`, holding the view's current exposed input
as a URL query string (e.g. `?id=3&page=1`). Use it to build links that carry the visitor's
active exposed-filter selections to another URL. Depends on core `views`. PHP >= 8.1,
core `^10.3 || ^11`. No config, permissions, routes or `src/`.

Key facts:
- Whole module is five files: `views_exposed_input_token.module` (the two hooks + a helper),
  `.info.yml`, `composer.json`, `CONTRIBUTING.txt`, `LICENSE.txt`.
- The token lives under the `view` token type, so it resolves only where the `view` object is
  passed to token replacement (Views Global text areas, view title, link-building areas) — not
  in generic node/entity token contexts.
- Value is `?` + `http_build_query($view->getExposedInput())`; empty string when there is no
  exposed input; the pager page is appended as `page=N` past page 0; internal Views routing
  keys are stripped.

Capabilities:
- [The `[view:exposed-input]` token — mechanism, placement, and query-string composition](api/views_exposed_input_token.md)
