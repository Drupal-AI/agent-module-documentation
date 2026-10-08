Node view permissions adds a per-content-type "View own content" and "View any content" permission for every node type, filling the gap where Drupal core only offers such granular view control for edit and delete — not for viewing.

---

Drupal core grants node view access through the single broad "access content" permission plus per-type "edit own/any" and "delete own/any" permissions, but it has no per-content-type control over who may *view* nodes. Node view permissions closes that gap. For each content type it dynamically declares two permissions — `view own {type} content` and `view any {type} content` — via a permission callback (`NodeViewPermissionsPermissions`, extending core's `NodePermissions`), so the list grows automatically as you add content types. Enforcement is done through Drupal's node access grant system: `hook_node_access_records()` writes a grant record per node keyed on realms like `view_any_{type}_content` and `view_own_{type}_content` (with parallel `view_any_unpublished_*` / `view_own_unpublished_*` and per-language realms), and `hook_node_grants()` returns the realms a given account qualifies for based on the permissions it holds. "Own" grants are scoped to the node's owner id, so a user sees only their own nodes of that type; "any" grants use gid 1 for everyone with the permission. Unpublished realms additionally require core's "view own/any unpublished content" permission, and the module respects publish status and translation language when building grants. On install it rebuilds node access and grants "view any {type} content" to the anonymous and authenticated roles for existing types so the site keeps working as before. Because it plugs into the standard node access API, the permissions also filter listings, Views, and search results — not just direct node pages. There is no admin settings form; you manage everything from the standard **People → Permissions** page.

---

- Let authors see only their own articles while hiding other authors' articles of that type.
- Give a role permission to view any "page" node but not any "article" node.
- Restrict a private content type so only its owner (and admins) can view each node.
- Build a member portal where each user sees only the nodes they authored.
- Hide an internal content type from anonymous visitors while showing others.
- Grant editors "view any" on all types while contributors get "view own" only.
- Filter Views listings automatically so users only see nodes they may view.
- Keep search results and node listings consistent with per-type view rules.
- Allow a support role to view any "ticket" node but only their own "note" nodes.
- Let freelancers view only the projects they own without a custom access module.
- Combine with core "view own/any unpublished content" to expose unpublished nodes per type.
- Show a user their own unpublished drafts of a type while hiding published ones from others.
- Enforce per-type visibility on a multilingual site, with grants scoped per translation language.
- Replace a hand-written `hook_node_access` with a maintained, permission-driven solution.
- Give anonymous users "view any" on brochure content types but nothing on private ones.
- Set up author-scoped dashboards where "view own X content" gates the listing.
- Lock down a "profile" content type so users only see their own profile node.
- Provide per-type read access to REST/JSON:API consumers via the node access grants.
- Add granular view control without writing or maintaining custom PHP.
- Let a moderator role view any content of every type by ticking the "any" permissions.
- Progressively open content types to roles as a site's access model evolves.
- Rebuild node access grants after changing which roles hold view permissions.
- Grant "view own" so users can preview their own submissions before an editor publishes.
- Model classified-listings sites where each seller sees only their own listings.
- Support intranet scenarios where departments see only their own department's node type.
