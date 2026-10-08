<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Personal Access Restriction (par) — agent index

Per-entity restriction of a **node's or term's page** by UID or role, configured on the entity form.
Permissions: `configure personal access restriction`, `manage personal access restriction`,
`view restricted pages` (a **site-wide bypass**; none is marked `restrict access`).
Version **3.0.9**. Core requirement `^8 || ^9 || ^10 || ^11`.

**Read this before recommending it — the scope is far narrower than "User access" suggests.**
The module implements **no entity access hook at all** — no `hook_node_access()`, no
`hook_node_grants()`, no `hook_query_TAG_alter()`. Its complete hook list is `help`, `form_alter`,
a submit handler, and **`hook_preprocess_node()` / `hook_preprocess_taxonomy_term()`**, gated on
`$variables['page']` and throwing `AccessDeniedHttpException` / `NotFoundHttpException` from inside
the theme layer.

**Therefore `$node->access('view')` is untouched, and all of these serve the content normally:**
JSON:API, REST, Views listings, search results and excerpts, teasers, RSS/feeds, sitemaps,
related-content blocks, and `node/{nid}/edit|revisions|delete`.

Two further notes: the decision carries **no cache context**, so nothing tells Drupal the page
varies by user; and `administrator` is **hard-coded as a role machine name** rather than checked as
a permission.

**Use it as a presentation feature — "do not show this page at this URL". Never as
confidentiality.** For that: core's node access system, or a module implementing grants.
