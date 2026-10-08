<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Site Meta sets a page's `<title>`, `<meta name="description">` and `<meta name="keywords">` from `Site meta` content entities matched by internal system path, with node/term token support.

---

Each rule is a `sitemeta` content entity with four fields: `path`, `name` (title), `description` and `keywords`. On every page, `sitemeta_preprocess_html()` takes the current internal path plus language and asks `SitemetaGenerator::getSiteMeta()` for a match — first an exact `path`+`langcode` lookup, then a wildcard pass over any rule whose `path` contains `%` (the part before the first `%` is treated as a prefix and matched with `str_contains` against both the internal path and its alias). A match sets `head_title['title']` (replacing the default title) and appends `description` / `keywords` meta tags to `html_head`. All three values are run through `\Drupal::token()->replace(..., ['clear' => TRUE])` with the current `node` and/or `taxonomy_term` as token data, so a rule like `/taxonomy/term/%` with description `[term:description]` fills in per term. Values are emitted through the render system (title via Twig `safe_join`, meta content as an escaped `html_tag` attribute), so admin-entered text is attribute-escaped, not raw. Rules are managed as entities at `admin/content/sitemeta` (list, add, edit, delete), each route gated by its own permission (`administer`/`add`/`edit`/`delete` `site meta entities`). Additionally `sitemeta_form_node_form_alter()` adds a "Custom meta" details group to the node edit form (advanced sidebar) whose submit handler saves/updates a `sitemeta` entity for that node's `/node/{nid}` path (the path field is disabled and forced to the node's own path). Note the module has no config schema, no config form, and no Open Graph / Twitter-card / canonical / robots tags — it is title + description + keywords only. Requires core `token`. The wildcard loop has a functional quirk (an early `return FALSE` inside the loop) that limits reliable matching to the first wildcard rule, so per-page exact rules are the dependable mode.

---

- Set a specific page's meta description.
- Override the `<title>` for a landing page independently of the node title.
- Add a meta description to a taxonomy term page.
- Use a path-prefix wildcard (`/taxonomy/term/%`) to cover a section.
- Build a description from a field with a token like `[node:field_summary]`.
- Set keywords on a specific node via the node edit form's "Custom meta" tab.
- Give a Views page its own title and description.
- Set meta tags for the front page by its internal path.
- Improve search-result snippets by writing tailored descriptions.
- Provide per-language meta for a path (rules are matched by langcode).
- Add lightweight SEO to a small site without installing `metatag`.
- Set a title for a path that has no node behind it.
- Manage all meta rules from one admin list at `admin/content/sitemeta`.
- Delegate meta editing to content editors through the node form.
- Populate a term-page description from `[term:description]`.
- Restrict who can create meta rules using the `add site meta entities` permission.
- Restrict who can delete meta rules using the `delete site meta entities` permission.
- Set keywords for a group of pages sharing a path prefix.
- Add a description to a `/forum/1` style path.
- Author a meta rule against a URL alias (it is resolved to the internal path on save).
- Keep meta values dynamic per node using node tokens in a wildcard rule.
- Audit and adjust existing rules from the entity list, which shows name, path and alias.
- Replace a stray default title on a page core titles poorly.
- Provide a stepping-stone SEO setup before migrating to `metatag`.
