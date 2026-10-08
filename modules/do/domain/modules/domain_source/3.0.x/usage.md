Domain Source assigns each content item a single canonical "source" domain and rewrites its outbound URLs to that domain, so shared multi-domain content always links back to one authoritative host.

---

Domain Source adds one field, `field_domain_source` (entity-reference to `domain`, cardinality 1), to nodes: the item's canonical source domain. When Drupal builds an outbound URL for that content, Domain Source's outbound path processor rewrites the link to point at the source domain instead of the currently active one — essential when the same node is published to several affiliate domains (via Domain Access) but should have one canonical URL for SEO and sharing. It integrates with `path_alias` so aliased paths are rewritten correctly. Certain routes can be excluded from rewriting through the `domain_source.settings` config (`exclude_routes`) managed at `/admin/config/domain/domain_source` (route `domain_source.settings`). The `domain_source.helper` service resolves an entity's source domain (`getSourceDomain()` / `getSourceDomainId()`), and several alter hooks (`hook_domain_source_alter`, `hook_domain_source_path_alter`, `hook_domain_source_excluded_paths_alter`, and route-exclusion variants) let modules override the chosen source or skip rewriting for specific paths/routes. Requires `node`, `path_alias`, and the core `domain` module.

---

- Give each node a single canonical source domain via `field_domain_source`.
- Ensure shared content published to many domains links to one canonical host.
- Rewrite outbound links so a node's URL points at its source domain, not the active one.
- Improve SEO by avoiding duplicate content across affiliate domains.
- Produce correct absolute URLs in feeds, sitemaps, and emails for multi-domain content.
- Keep social-share URLs pointing at the authoritative domain.
- Resolve an entity's source domain in code with `getSourceDomain()`.
- Get just the source domain id with `getSourceDomainId()`.
- Leave a node's source unset to fall back to normal (active-domain) URL behavior.
- Exclude specific routes from URL rewriting via `domain_source.settings:exclude_routes`.
- Exclude particular paths from rewriting with `hook_domain_source_excluded_paths_alter`.
- Exclude routes by name with `hook_domain_source_excluded_route_names_alter`.
- Override the computed source domain per URL via `hook_domain_source_alter`.
- Alter the rewritten path itself with `hook_domain_source_path_alter`.
- Adjust the exclude-routes form options with `hook_domain_source_exclude_routes_options_alter`.
- Pair with Domain Access so multi-affiliate content keeps one canonical link.
- Set a default source domain on content-creation forms.
- Confirm the source field exists on a bundle programmatically with `confirmFields()`.
- Ensure canonical URLs work with path aliases through the path_alias integration.
- Rewrite menu and reference links to a node so they target its source domain.
