<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views entity_access check runs a full entity access check on every row a selected view returns, discarding the rows the current user is not allowed to view.

---

The module exists to close one of Drupal's oldest and least-understood access gaps, which its own project page names: core issue **777578**, open since 2010. Views builds its result set with a database query; for nodes that query is filtered by the SQL-level **node access grants** system, and for other entity types it is filtered by whatever `hook_query_TAG_alter()` implementations exist. But `hook_entity_access()` / `hook_node_access()` — where many access modules actually decide, in PHP, at the moment code calls `$entity->access('view')` — is **not consulted for listings**. A module that grants or denies access at runtime with logic too complex to express in SQL therefore has no effect inside Views, and a view can list entities the viewer may not open: the title, the configured row fields and often a teaser are all rendered, and clicking through returns access-denied. In the worst case a restricted document's title surfaces in a search-results view. This module is the only fix available from outside core: it implements **`hook_views_pre_render()`**, and for each view whose machine name you have selected on its settings form it walks `$view->result`, calls `$row->_entity->access('view')` for the current user, and `unset()`s every row that fails. It is deliberately narrow — a single `'view'` operation, no per-view configuration of the operation, no plugins, no fields, no query alteration. The mechanism is a hard-coded loop the author openly calls a "hacky workaround," and the **0.0.4 / 0.0.x** version number is a statement that it should never need a stable release: the real fix belongs in core. Two functional consequences follow from filtering *after* the query and must be planned for. The **pager and total count are computed from the unfiltered query**, so a page sized for ten rows can display fewer and the reported total is wrong. And it **loads and access-checks one entity per row**, which is exactly the work the query was designed to avoid — so it is enabled per-view, only on the views that need it, never globally. The module's own settings screen warns that it "impacts performance and caching," and the maintainers ask users to help fix 777578 upstream so the module can be retired.

---

- Stop a view from listing entities the current user has no `view` access to.
- Hide restricted documents whose titles would otherwise leak in a search-results view.
- Make a runtime `hook_entity_access()` decision actually apply inside Views listings.
- Work around core issue 777578 without writing custom code.
- Filter a view's rows by real entity access rather than by node grants alone.
- Enforce access on a listing of non-node entities (media, custom entities) that grants cannot cover.
- Complement grant-less access modules such as entity_access_by_reference_field or entity_access_by_role_field.
- Protect an intranet or members-only listing built as a view.
- Hide group-restricted content that a Views query does not know is restricted.
- Secure a report or feed view against showing forbidden rows.
- Apply per-entity access to a taxonomy-term or media listing.
- Remove rows a user cannot open before the pager and row markup are rendered.
- Add an entity-access safety net to a view whose query-level filtering is incomplete.
- Select a specific set of views by machine name to apply the extra check to.
- Turn the check on only for the handful of views that actually leak, leaving others untouched.
- Mitigate an information-disclosure report where a custom access module's rules are ignored in Views.
- Bridge the gap for an access module that cannot implement `hook_query_TAG_alter()`.
- Provide interim protection while a proper query-level access solution is developed for an access module.
- Verify (in a staging view) which rows a given account may actually see.
- Retire the workaround later by disabling the module once core or an access module fixes the query.
