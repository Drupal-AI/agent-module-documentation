<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Personal Access Restriction hides a node's or term's page from chosen users or roles, configured per entity on its edit form.

---

The requirement it answers is common: one page that should not be visible to a particular role, a term whose listing is for staff only, a handful of nodes kept from a group without building a whole permission scheme. Core's answer is node access, which is powerful and heavy — grants, a rebuild, and a mental model most site builders would rather not acquire for three pages. A per-node checkbox is far more approachable. Version **3.0.9** on `^8` through `^11`, with three permissions: `configure personal access restriction`, `manage personal access restriction` and `view restricted pages`, the last being a site-wide bypass. **Understand exactly what it enforces before using it, because the scope is much narrower than the package name suggests.** The module implements no entity access hook of any kind — no `hook_node_access()`, no grants, no query alter. Its entire enforcement is `hook_preprocess_node()` and `hook_preprocess_taxonomy_term()`, gated on the full-page render, throwing an exception from inside the theme layer. `$node->access('view')` is therefore untouched, and everything that asks Drupal that question — JSON:API, REST, Views listings, search results, teasers, feeds, related-content blocks — serves the content normally. Treat it as a presentation feature meaning "do not show this page at this URL", never as confidentiality: for that, core's node access system or a module implementing grants is the answer.

---

- Hide a page from a specific role.
- Keep a node's page from a group.
- Restrict a term's listing page.
- Hide a page without a permission scheme.
- Show a 404 instead of a 403.
- Restrict a page to named users.
- Hide a draft-like page from members.
- Keep an internal page out of general view.
- Restrict a landing page by role.
- Hide a page during a soft launch.
- Restrict a term page to staff.
- Give an editor per-node control.
- Hide a page from anonymous visitors.
- Reverse a restriction to an allow-list.
- Restrict a few pages without node access.
- Configure restrictions per entity.
- Hide a legacy page's URL.
- Bypass restrictions for a support role.
