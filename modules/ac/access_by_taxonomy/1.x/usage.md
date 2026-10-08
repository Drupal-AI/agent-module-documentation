Restrict who can view a node by the taxonomy terms attached to it, enforced through Drupal's core node access grant system.

---

Access By Taxonomy adds two entity-reference fields — `field_allowed_users` and `field_allowed_roles` — to every taxonomy vocabulary. On each term you list the roles and/or users that are allowed to view content. When a term is referenced by a node (through any `entity_reference` field targeting `taxonomy_term`), the module writes node access grant records so that only the allowed roles/users, the node author, and holders of a per-content-type "view any" permission can see it. Terms left empty impose no restriction, so tagging a node with only unrestricted terms leaves it public. The module works at the query level (restricted nodes disappear from listings, Views and search, not just their canonical page), supports content translation (grants are computed per translation language), takes over the core Views "Published status or admin" filter so "view any" holders still see matching content, and provides an AJAX preview on the node form showing how the saved grants would change. It only governs the `view` operation — `update`/`delete` remain with core node permissions.

---

- Limit a set of "members only" articles to an authenticated role by tagging them with a members-only term.
- Give a specific list of named users access to sensitive documents by adding them to a term's Allowed users field.
- Build a simple intranet where each department vocabulary term grants access to that department's staff role.
- Publish premium content that only a "subscriber" role can read, tagged with a "premium" term.
- Restrict case files to the caseworkers assigned to them by listing those users on a per-case term.
- Hide draft campaign pages from the public while a term restricts them to the marketing team role.
- Let editors preview how access will change before saving, using the "Preview access changes" diff on the node edit form.
- Grant a support role blanket "View any" access to every Basic page via the per-type "access by taxonomy view any page content" permission.
- Combine several tags: a node visible to either the "editor" role OR three named reviewers by using two terms.
- Keep taxonomy-driven access consistent across English/French/German translations of the same node.
- Ensure restricted nodes never leak into a Views listing, a search index result, or an entity query.
- Delegate term-level access administration per vocabulary with the "administer access for terms in [vocabulary]" permission, without granting full "administer taxonomy".
- Automatically re-secure all affected nodes when a term's allowed roles/users change (batch rebuild runs on term update).
- Clean up grants automatically when a role or user is deleted, so stale access rows do not linger in `node_access`.
- Filter an entity query of taxonomy terms down to those the current user may access by tagging the query with `access_by_taxonomy`.
- Hide restricted taxonomy terms themselves from users who lack access (term view access is also enforced).
- Give a role access to an entire content type regardless of tags by assigning the module's per-type "view any" permission.
- Let node authors always view their own restricted content, including their own unpublished translations when they hold "view own unpublished content".
- Migrate away from a heavier per-term access module by relying solely on core node access hooks.
- Apply access rules to any node type simply by adding a taxonomy term reference field and tagging content.
