<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Role Access lets you grant a Domain Access domain to every member of one or more user roles, instead of assigning the domain per user.

---

Domain Access (the `domain_access` module) normally decides which domains a user can act on from a per-user field on their profile. Domain Role Access adds a second, role-based source: on each domain's admin page you pick the roles that should have that domain's access, and every user in those roles is treated as if the domain were set in their profile. It implements this by decorating Domain Access's `DomainAccessManager` service and extending its static `getAccessValues()` — the role-derived domains are merged (OR logic) into the per-user field values, so nothing is overridden or removed; the module only ever adds domains. Because the result flows back through Domain Access, all real enforcement (node grants, entity/field access) stays with Domain Access; this module changes only the set of domains a user is considered to have. It requires the `domain`, `domain_config` and `domain_access` modules, stores each domain's role list in a `domain.roles.<domain_id>` config object, and adds a "Roles" operation link to every domain in the domain admin listing. Managing the role lists requires the `administer domains` permission.

---

- Grant a whole role access to a specific domain without editing each user's profile field.
- Give an "Editor" role access to a staging or regional domain in one place.
- Onboard new staff to a domain automatically by assigning them the mapped role.
- Combine role-based and per-user domain access (both apply; results are OR-combined).
- Map several roles to the same domain so any of them grants that domain's access.
- Map one role to several domains by assigning that role on each domain's Roles page.
- Manage a multi-domain / affiliate site where access tracks job function (role), not individuals.
- Remove a role's access to a domain by unchecking it (deletes the `domain.roles.<id>` entry).
- Revoke domain access for many users at once by removing a role from a domain.
- Keep per-domain access lists as configuration you can export and deploy between environments.
- Let editors publish/view domain-assigned content on domains their role is mapped to.
- Restrict a role to only the domains you explicitly map, leaving other domains unaffected.
- Audit which roles can reach a domain from that domain's single Roles form.
- Apply role-based domain access to any fieldable user entity that Domain Access already governs.
- Set up domain access for anonymous or authenticated roles site-wide via their role mapping.
- Reduce per-user administration on large sites by managing access at the role level.
- Delegate domain access management to administrators holding `administer domains`.
- Deploy consistent domain/role access across dev, stage and prod via config sync.
- Extend an existing Domain Access install with role support without changing its enforcement.
