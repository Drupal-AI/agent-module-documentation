<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Group Sites takes a Group entity supplied by a pluggable context provider, makes it the site's active Group, and alters the calculated group permissions based on whether a Group was found — the usual policy being "keep only the active Group, deactivate every other Group".

---

The problem it solves is running several sites from one Drupal install without running several Drupal installs. Given a context provider that maps the current request (typically the domain) to a Group — `group_context_domain` is the recommended one — this module denies access to every other Group's content, so each domain behaves like its own website while sharing one codebase, one user table and one admin.

Mechanically it hooks into Group's Flexible Permissions system. `GroupSitesAccessPolicy` is registered as a `flexible_permission_calculator` (priority `-500`) and implements `alterPermissions()`. On each permission calculation it asks `GroupSitesNegotiator` for the active Group (read from the configured context provider via core's `ContextRepository`). If a Group is found it runs the configured "site" policy; if none is found it runs the configured "no site" policy. The shipped site policy, `SingleSiteAccessPolicy`, strips every calculated permission item except the active Group's, flattening insider/outsider bundle permissions into that one group. The shipped no-site policies are `DenyAllNoSiteAccessPolicy` (the default and recommended — removes all items) and `DoNothingNoSiteAccessPolicy` (leaves permissions untouched, as if the module were not installed).

The design is deliberately open at both ends. Two tagged-service interfaces let you supply your own behaviour: `GroupSitesNoSiteAccessPolicyInterface` (tag `group_sites_no_site_access_policy`) for what happens when no Group is detected, and `GroupSitesSiteAccessPolicyInterface` (tag `group_sites_site_access_policy`) for what happens when one is. The README points at the Flexible Permissions module for anyone writing their own; priority only affects ordering on the settings form.

Admin mode is the part to understand before granting anything. Toggled from the admin toolbar, it makes the site behave "as if Group Sites wasn't even installed" — it short-circuits `alterPermissions()` so the scoping that is the entire point of the module is turned off for that user's session. That is genuinely needed for site building, and it is correctly gated behind its own `use group_sites admin mode` permission, stored per-user in the private tempstore, with routes that refuse to activate a mode already active. But whoever holds that permission can see and edit every microsite's content, so it belongs to a named administrative role and nothing else.

The README explicitly discourages the built-in "Group from URL" context in favour of a real context provider, because a context that does not always return a Group leads to an inconsistent experience.

---

- Run several microsites from one Drupal install sharing one codebase.
- Scope group access to the Group that represents the current domain.
- Deactivate every Group except the active site's.
- Derive the active Group from the domain via `group_context_domain`.
- Derive the active Group from a path prefix, language, or any custom context provider.
- Share one user table and one admin across all microsites.
- Deny all group access when no site context is found (fail-safe default).
- Choose "do nothing" when no site is found so the site behaves as if the module were off.
- Register the `GroupSitesAccessPolicy` calculator into Group's Flexible Permissions chain.
- Write a custom no-site access policy with `GroupSitesNoSiteAccessPolicyInterface`.
- Write a custom site access policy with `GroupSitesSiteAccessPolicyInterface`.
- Toggle admin mode from the toolbar to build and manage all sites from one place.
- Restrict admin mode to a named administrative role only.
- Audit who holds `use group_sites admin mode` before going live.
- Grant `configure group_sites` separately to whoever tunes the settings.
- Configure the context provider and both access policies at `/admin/group/sites/settings`.
- Avoid the discouraged "Group from URL" context provider.
- Keep permissions cached correctly across admin-mode toggles via the `user.in_group_sites_admin_mode` cache context.
- Abstract microsite logic away from any specific "source of selection" (domain, path, language).
- Combine with the Domain module for full per-domain entity and query access.
- Study the Flexible Permissions module before writing a policy.
- Let non-members of a microsite's Group fall back to outsider permissions within only that Group.
- Present each context provider's Group options as radios on the settings form.
- Keep the deny-all no-site policy as a safety net if a context provider ever fails to return a Group.
