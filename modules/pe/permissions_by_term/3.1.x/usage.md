<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions by Term restricts who may see (and select) content by attaching allowed **users and roles to taxonomy terms**: a node that references a restricted term is only visible to the accounts and roles granted that term.

---

Grants live in two custom database tables — `permissions_by_term_user` (`tid`, `uid`, `langcode`) and `permissions_by_term_role` (`tid`, `rid`, `langcode`) — written from a *Permissions* fieldset added to the taxonomy term form and a *Permissions → Vocabularies* multi-select added to the user edit form. Enforcement happens on three levels: `hook_node_access_records()` / `hook_node_grants()` publish core **node access records** in the `permissions_by_term` realm so restricted nodes disappear from Views listings, menus, search and `/admin/content`; `hook_node_access()` denies direct node views and dispatches a `permissions_by_term.access.denied` event; and `hook_options_list_alter()` plus a form validator strip terms the editor may not use out of taxonomy reference widgets. Three settings change the model: `permission_mode` (nodes are invisible unless *explicitly* granted, including nodes with no terms at all), `require_all_terms_granted` (the user must hold **all** of a node's terms, not just one), and `disable_node_access_records` (skip the grant records for performance, restricting only node view/edit). `target_bundles` limits everything to selected vocabularies, and two further booleans control the user-form widget and the node-form info panel. Because grants are cached in the `permissions_by_term` cache bin and materialised as node access records, changing terms or users triggers rebuilds — the Drush command `permissions-by-term:rebuild` (`pbtr`) forces one. The bundled submodule **Permissions by Entity** extends the same term grants to non-node fieldable entities.

---

- Build a members-only area where "Premium" tagged articles are visible only to the premium role.
- Give each school class its own taxonomy term so pupils only see their own class's pages.
- Run a company intranet where each department's term gates that department's documents.
- Grant a single named user access to one confidential term without creating a role for them.
- Hide unpublished workflow content from editors by tagging it with a restricted term.
- Restrict content in Views listings, menus and search results without writing a Views filter.
- Enforce that a node tagged with several restricted terms needs **all** of them (`require_all_terms_granted`).
- Switch to whitelist semantics with `permission_mode` so untagged nodes are hidden by default.
- Limit the term-reference options an editor can pick so they cannot publish into a restricted section.
- Prevent an editor from saving a node with a term they are not allowed to use (form validation error).
- Restrict permission management to a couple of vocabularies with `target_bundles`.
- Show only top-level terms on the user form (`only_parents`) when a vocabulary has hundreds of children.
- Speed up large `/admin/content` listings by turning off node access records when you only need view/edit restrictions.
- Rebuild the node grants after a bulk import with `drush permissions-by-term:rebuild`.
- Generate load-test content with `drush permissions-by-term:create-nodes-with-permissions 1000`.
- Delegate term permission editing to an editor role via `show term permission form on term page`.
- Let a support role see (but not change) which users and roles may read a node, on the node form.
- React to a denied access with an event subscriber on `permissions_by_term.access.denied` (e.g. redirect to a paywall).
- Migrate legacy user→term grants with the `permissions_by_term_user` migrate destination plugin.
- Hide client-specific project pages in a multi-client agency site.
- Grant access per language by writing grants with the right `langcode` on a multilingual site.
- Automatically drop a user's grants when their account is cancelled (handled by `hook_user_cancel()`).
- Automatically drop all grants for a term when the term is deleted.
- Extend the same term rules to media, paragraphs or custom entities with the Permissions by Entity submodule.
- Audit who can read a node by reading the `permissions_by_term_user` / `permissions_by_term_role` tables.
- Combine with role-based landing pages so each audience sees a different subset of the same view.
