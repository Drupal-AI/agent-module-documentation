<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Domain maps the current request's domain to a specific Group and its content, associating domains with groups.

---

Group Domain maps the current domain to a Group — so on a multi-domain site each domain can be
associated with a Group, and that group's content/context applies for requests on that domain. It bridges
the Group module with domain-based multi-site setups. It depends on the Group module.

Use it where distinct domains should correspond to distinct groups (multi-tenant/affiliate sites built on
Group). It is a site-structure/access-adjacent feature: because it ties a domain to a group, it influences
which group's content and membership context is active per domain — so verify the mapping matches your
intended isolation (a domain should surface only its group's content if that is the goal), and remember
Group's own access controls still govern what members can do. Configure the domain-to-group mapping.

---

- Map a domain to a Group.
- Associate domains with groups.
- Support multi-domain group sites.
- Apply a group's context per domain.
- Depend on the Group module.
- Bridge Group with domains.
- Build multi-tenant sites.
- Verify the domain-to-group mapping.
- Surface a group's content per domain.
- Rely on Group's access controls.
- Isolate content per domain.
- Configure the mapping.
- Handle affiliate/tenant domains.
- Set the active group by domain.
- Scope content to a domain's group.
- Manage multi-domain groups.
- Tie domains to group context.
- Verify intended isolation.
- Support Group multi-site.
- Configure domain groups.
