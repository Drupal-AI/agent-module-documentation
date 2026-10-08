Group Context: Domain ties one Group entity to one Domain record and exposes the active domain's Group as a core context, so blocks and other context-aware code know which group they are on without a group ID in the URL.

---

The Group module normally derives its context from the route: you are "in" a group because you are viewing that group's content or its canonical page. On a multi-domain site built with the Domain module, that route-based context is missing on generic pages like the tenant homepage even though the domain already implies the group. This module fills the gap. An editor with the "set domain group" permission opens a domain record's edit form, picks a group they are allowed to edit from a select list, and the group's UUID is stored as a third-party setting on the domain. From then on the `GroupFromDomainContext` context provider returns that group on every request served from the domain, and a companion `url.site.group` cache context lets any consuming render array vary its cache per detected group. A `DomainGroupUnique` validation constraint keeps the mapping one-to-one: a group cannot be tied to two domains, and a domain cannot claim a group already tied to another domain. It is presentation and integration plumbing — most visibly it lets group-context blocks (such as the Group operations block) render site-wide on a tenant domain, and it lets the Group Sites module scope a site to the group behind the active domain. It provides no routes, no settings form, and no external calls; everything is an entity third-party setting plus two context services.

---

- Show a group-context block on a tenant's homepage, not only on its group pages.
- Place the Group operations block so it renders across a whole tenant domain.
- Assign one group to represent a domain from the domain record edit form.
- Grant an editor the "set domain group" permission scoped to groups they can edit.
- Drive the Group Sites module to scope a site to the domain's group.
- Run a single Drupal install serving many tenants, one group and domain per tenant.
- Vary block or render-array caching per group with the `url.site.group` cache context.
- Consume the "Group from domain" context from any core context-aware plugin.
- Reuse the group-from-domain lookup in your own service via `GroupFromDomainContextTrait`.
- Enforce a strict one-group-per-domain, one-domain-per-group relationship at validation time.
- Clear a domain's group assignment by selecting the empty option on the domain form.
- Detect the active group in custom code without parsing the request path.
- Build tenant-aware menus, breadcrumbs, or messaging keyed off the domain's group.
- Let context-condition-based visibility work on non-group routes of a tenant site.
- Confirm what the context returns when a domain has no group assigned (it returns none).
- Confirm the validator's behaviour when two domains attempt to share one group.
- Audit which domains map to which groups by inspecting domain third-party settings.
- Plan a multi-tenant Group + Domain architecture that needs site-wide group context.
- Give theme or block logic a stable per-domain group signal for cache invalidation.
- Integrate a custom context consumer that expects a group context to always be present.
- Migrate a route-based group-context setup to a domain-based one on a multi-site build.
- Review the mapping during a site audit or after a Group or Domain module upgrade.
