# Configuration

Group Sites is configured in two places: the **settings form**, where you choose
how the module behaves, and **admin mode**, which you toggle from the toolbar while
building the site. This page walks through both, and the access policies that make
the microsites work.

## Open the settings form

1. Log in as a user with the **configure group_sites** permission (an
   administrator by default).
2. Go to **Administration → Groups → Sites → Settings**, or navigate directly to
   `/admin/group/sites/settings`.

## Choosing your access policies

Group Sites works by applying an access policy based on whether a Group was found
by your context provider. There are two decisions:

- **When a Group *is* found** — the module ships a single policy that disables
  access to all Groups except the active one. This is what splits your install into
  microsites: on a domain mapped to "Group A", only Group A's content is reachable.
- **When *no* Group is found** — the module ships a **deny‑all** policy, which is
  the default and the recommended choice. It means a request that doesn't resolve
  to any Group is denied rather than allowed to see everything.

Developers can supply their own policies for either case through tagged services
(the `GroupSitesSiteAccessPolicyInterface` and
`GroupSitesNoSiteAccessPolicyInterface` interfaces); the README suggests the
[Flexible Permissions](https://www.drupal.org/project/flexible_permissions) module
as a starting point for custom logic. If you don't need custom behaviour, the
shipped defaults are the intended setup.

## The context provider

Group Sites itself doesn't decide *which* Group is active — a context provider
does. Install and configure one that returns a Group context; the recommended
choice is **Group Context: Domain** (`group_context_domain`), which maps the
current domain to a Group. The module works equally well with a context based on a
path prefix, language, or anything else. The README explicitly **discourages** the
built‑in "Group from URL" context in favour of a real context provider.

## Admin mode — read this before granting it

Admin mode is toggled from the **admin toolbar**. While it's on, the site behaves
"as if Group Sites wasn't even installed" — the access scoping is switched off
entirely, so you can build and manage every microsite's content in one place. This
is genuinely useful (and often necessary) during site building.

It is gated behind its own **use group_sites admin mode** permission, and the
routes that activate or deactivate it refuse to switch to a mode that's already
active. But be clear about the consequence: **anyone holding that permission can
see and edit every microsite's content.** Grant **use group_sites admin mode** to a
single named administrative role only — never to ordinary editors or per‑site
managers — and audit who holds it.

Remember to turn admin mode **off** when you've finished building, so the access
scoping that defines your microsites is back in force.

## Permissions summary

- **configure group_sites** — access this settings form.
- **use group_sites admin mode** — bypass all Group Sites access scoping via the
  toolbar toggle. Highly sensitive; named administrators only.
