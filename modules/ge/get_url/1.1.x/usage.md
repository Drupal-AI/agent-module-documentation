<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Twig Get URL adds a `get_url()` Twig function that takes an internal system path such as `/node/42` and returns its URL alias, letting themers build links in templates without custom preprocess code.

The module is a single Twig extension (`Drupal\get_url\TwigExtension`, registered via `get_url.services.yml`) exposing one function, `get_url`. The static `getUrl($nodeId)` implementation first validates the argument against the regex `^/[a-zA-Z_-]+/\d+$` (e.g. `/node/42`), returning an empty string for anything that doesn't match — so it accepts only a `/segment/number` system path, not an arbitrary string. It then resolves the alias with `path_alias.manager::getAliasByPath()`.

From a security standpoint the function does **not** fetch any remote or user-supplied URL server-side — there is no `http_client`, `file_get_contents`, or cURL call, so there is no SSRF surface. It also guards against an alias that has been pointed at an external URL (`UrlHelper::isExternal($alias)` → returns `''`) and escapes the result with `Html::escape()` before wrapping it in `Markup`. The function is marked `is_safe => html`, but because output is the escaped internal alias, the practical risk is limited to what a site's own path aliases contain.
---
No routes, permissions, or config. Input is constrained by a strict regex to `/segment/digits`; external-alias results are suppressed; output is HTML-escaped. No server-side URL fetching (no SSRF). Marked `is_safe: html` — the returned value is an escaped internal path alias.
---
- Print a node's alias in a Twig template with `{{ get_url('/node/' ~ nid) }}`.
- Build a link `href` from a node ID without a preprocess function.
- Generate menu or teaser links from raw entity IDs in a template.
- Resolve `/taxonomy_term/5` style paths to their aliases in Twig.
- Create "read more" links pointing at a node's aliased URL.
- Output canonical-looking internal paths in custom card components.
- Avoid writing `hook_preprocess` just to fetch a URL alias.
- Link related-content lists rendered from IDs in a Twig loop.
- Use the function inside a Views field rewritten with Twig (where available).
- Safely no-op when given a malformed path (returns empty string).
- Suppress links when an alias resolves to an external URL.
- Produce breadcrumb-style links from known system paths.
- Reference a node URL from a paragraph or block template.
- Keep template link logic declarative rather than in PHP.
- Build sitemap-like link lists in a custom template.
- Combine with Twig concatenation to assemble paths dynamically.
- Fetch aliases for content-type-prefixed paths like `/article/12`.
