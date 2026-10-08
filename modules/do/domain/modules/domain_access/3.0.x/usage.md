Domain Access is the flagship submodule of Domain: it adds per-domain access control to content and users, so each node (and editor) is scoped to one or more affiliate domains.

---

Domain Access attaches two fields to nodes and users: `field_domain_access` (entity-reference to `domain`, cardinality unlimited — the domains an item belongs to) and `field_domain_all_affiliates` (boolean — "publish to all domains"). A node access grant system then filters what each visitor and editor can see and manage based on the active domain and the user's assigned domains. Editors get per-domain permissions (create/edit/delete/view-unpublished content on assigned domains, publish to assigned or any domain, assign editors) rather than site-wide ones, enabling delegated affiliate publishing. The `DomainAccessManager` service (`domain_access.manager`) resolves an entity's domains, checks entity access, and computes per-domain permission checks. Settings at `/admin/config/domain/domain_access` (route `domain_access.settings`) control whether the domain field appears on a node's "advanced" tab, whether it starts open, whether domain fields may be removed, and whether per-bundle node access grants are enabled. It also ships a `domain_access` condition plugin and bundled actions to assign/remove content and editors to/from all affiliates. Requires `node` and the core `domain` module.

---

- Scope each node to one or more affiliate domains via `field_domain_access`.
- Publish a node to every domain at once with the `field_domain_all_affiliates` "all affiliates" flag.
- Hide content from visitors browsing a domain the node is not assigned to.
- Let editors create/edit/delete content only on their assigned domains (`create/edit/delete domain content`).
- Grant "publish to any domain" or "publish to any assigned domain" selectively.
- Allow trusted users to assign additional editors to assigned domains (`assign domain editors`).
- Give super-editors "assign editors to any domain".
- Let editors view unpublished content on their assigned domains.
- Add per-content-type permissions like "Article: create new content on assigned domains".
- Assign a user to domains with `field_domain_access` on the user entity.
- Bulk-assign content to all affiliates with the "Assign content to all affiliates" action.
- Bulk-remove content from all affiliates with the matching action.
- Bulk-assign or remove editors to/from all affiliates via the user actions.
- Move the domain access field onto the node "advanced" (vertical tabs) area, optionally open by default.
- Enable per-bundle node access grants for finer-grained access.
- Check an entity's domains programmatically with `DomainAccessManager::getAccessValues()` / `getContentUrls()`.
- Test whether a user has given permissions on a specific domain with `hasDomainPermissions()`.
- Show or hide blocks by the node's domain assignment using the `domain_access` condition.
- Set a default domain value for new content (third-party "add current domain" field setting).
- Build an editorial workflow where each brand's team only touches its own content.
- Combine with `domain_source` so shared multi-domain content still has one canonical URL.
- Restrict which domains a user may assign content to via `hook_domain_references_alter`.
