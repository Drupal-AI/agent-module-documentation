Masquerade as Role lets a permitted user temporarily view the site as if they held a different set of roles, without changing which user account they are logged in as (unlike the Masquerade module, which switches user).

---

The module works by overriding the `user` entity class with `MasqueradeRoleUser` (which overrides `getRoles()`) and swapping the `current_user` service for a `MasqueradeAccountProxy`, so while masquerade is active the current user reports the chosen roles while keeping their real user id. Masquerade state (active flag + chosen role ids) is stored per user in `user.data` under the `msqrole` module key and managed by the `msqrole.manager` service (`RoleManagerInterface`). A user with the `masquerade role` permission uses the form at `/admin/people/masquerade-role` to pick roles; per-role access is gated by dynamically generated `masquerade as <role_id>` permissions (one per configurable role, excluding anonymous/authenticated/administrator). Users with `create masquerade role link` can generate shareable links (via `RoleManager::generateUrl()`, stored in the `msqrole.urls` key/value collection, optionally single-use) that activate a role set through the `msqrole.set` route; the `msqrole.reset` route clears masquerade. Because masqueraded permissions can leak through Drupal's render cache, the module registers an `msqrole_is_active` cache context, invalidates a fixed set of cache tags on activation, and lets admins add extra tags to invalidate via `msqrole.settings` (`tags_to_invalidate`) at `/admin/config/people/masquerade-role`. A small status widget shows the active roles and a reset link.

---

- View a page exactly as an "editor" or "member" role would see it, while staying logged in as admin.
- QA a site's permission setup by switching roles on the fly during testing.
- Check which blocks, menu links, or local tasks a given role can and cannot see.
- Verify content access rules for a role without creating a throwaway test user.
- Debug "why can this role see X?" by masquerading into that role and inspecting the page.
- Generate a shareable link that puts a colleague into a specific role set for a demo.
- Create a single-use masquerade-role link for a one-off review session.
- Grant a support agent permission to preview the site as a customer-facing role.
- Give designers a link to see the site as an unauthenticated-plus-member combination.
- Reset back to your real roles instantly via the reset link/route.
- Add custom cache tags to invalidate so cached blocks refresh when roles switch.
- Diagnose render-cache leakage between admins by relying on the msqrole_is_active cache context.
- Test role-based Views access without logging in and out of multiple accounts.
- Confirm a newly added permission actually affects a role's experience.
- Preview an editorial workflow step visible only to a certain role.
- Let developers reproduce a role-specific bug on production-like data safely.
- Restrict who may impersonate each role using the per-role `masquerade as <role>` permissions.
- Keep audit clarity by preserving the real user id while changing effective roles.
- Programmatically activate a role set for the current user via the msqrole.manager service.
- Build a custom "preview as role" button that links to the msqrole.set route with a key.
- Check theme/region visibility differences across roles quickly.
- Validate that administrator-only tools stay hidden from lesser roles.
- Onboard new team members by showing them the site from several role perspectives.
- Temporarily drop elevated permissions to sanity-check a low-privilege experience.
