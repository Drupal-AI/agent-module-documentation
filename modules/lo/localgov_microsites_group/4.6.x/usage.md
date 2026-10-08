<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LocalGov Microsites Group turns the Group module into a multi-tenant microsites platform: each microsite is a Group of the `microsite` type, bound to a domain, with its own theme, enabled feature modules, content types and members.
---
A microsite is created via `/admin/microsites/add/{group_type}` (gated by Group's `_entity_create_access`) which seeds default group content, roles and a domain binding. Per-microsite configuration is delivered through a `DomainGroupSettings` plugin type (Theme, Site settings, Content types, Domain) collected into a settings form at `/group/{group}/domain-settings`; the `MicrositeAdminController` resolves the "current" microsite from the domain/group context provider so a site admin lands on their own group's admin. A `ThemeSwitcherNegotiator`, context provider (`DomainGroupContext`) and a suite of event subscribers (replicate group content, redirect group content, Search API access, config sync) wire domain → group resolution across the stack. The submodule `localgov_microsites_permissions` extends `group_permissions` so a microsite administrator can set their own per-group permissions, and content-type submodules (blogs, news, events, guides, directories, publications, step-by-step) add per-microsite content.

Access is layered on Group: routes use `_entity_create_access` or `_custom_access`. The domain-settings form access grants on `bypass domain group permissions` OR any settings plugin's own `access($group, $account)` check; the microsite-admin redirect only allows when a current-group context resolves. Two custom Access Policies (`ControlSiteAccessPolicy`, `MicrositeContentTypesAccessPolicy`) refine what each microsite exposes. Operationally you install the (large) dependency stack, create microsite group types, add the domain, assign members/roles via ginvite and role_delegation, and toggle feature modules per microsite.
---
Create a new microsite bound to a domain.
- Assign a theme override per microsite.
- Toggle feature modules on/off per microsite.
- Configure per-microsite site settings (name, email, etc.).
- Enable/disable content types per microsite.
- Invite users into a microsite with ginvite.
- Delegate microsite roles with role_delegation.
- Grant `bypass domain group permissions` to super-admins.
- Let microsite admins set their own group permissions.
- Route a domain to its owning Group via domain context.
- Redirect group content to the correct microsite domain.
- Replicate default content into a new microsite.
- Add blogs content to a microsite (submodule).
- Add news content to a microsite (submodule).
- Add events content to a microsite (submodule).
- Add guides / step-by-step content to a microsite.
- Add directories or publications to a microsite.
- Enable per-microsite webforms via the group_webform submodule.
- Land a site admin on their current microsite's admin.
- Scope Search API results to a microsite's content.
- Manage microsite membership and roles from the group UI.
- Build a Microsites overview page for platform admins.
- Override the base theme for a domain group.