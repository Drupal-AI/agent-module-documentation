<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Maps user roles to a Toolbar Menu so the right admin toolbar menu is shown automatically per role after login.

---

This module extends the contrib Toolbar Menu module, which lets you expose an arbitrary menu inside the admin toolbar. On its own Toolbar Menu shows every configured toolbar menu; Default Toolbar Menu adds a role-to-menu mapping so a given role sees one specific menu by default. Configuration lives at `/admin/config/user-interface/toolbar_menu/setting` (route `default_toolbar_menu.default_admin_menu_setting_form`), gated by the `set default toolbar menu for roles` permission, and is stored in the `default_toolbar_menu.setting` config object under `default_menu`.

The switching logic is hook-driven. On `hook_user_login` the module resolves the account's roles against the configured mapping and writes the chosen menu id into Drupal `state` keyed by user id (`default_toolbar_menu:<uid>`). On `hook_page_attachments`, for authenticated users holding `access toolbar`, it attaches the `default_toolbar_menu/default_toolbar_menu` JS library plus `drupalSettings` (menu id + uid) and adds the `user` cache context so the client-side script activates the correct menu. Because the selection is stored in state at login, the effective menu only updates on the next login.

---

- Show a role-specific admin toolbar menu automatically.
- Map the administrator role to a full admin menu.
- Map an editor role to a slimmed editorial menu.
- Give content authors a curated toolbar menu.
- Reduce toolbar clutter for limited-access roles.
- Configure the mapping at the settings form.
- Grant the `set default toolbar menu for roles` permission to trusted admins.
- Pick a Toolbar Menu per role from a select list.
- Leave a role's menu blank to fall back to default behavior.
- Combine several roles, each with its own menu.
- Ensure the role also has `access toolbar` so the menu attaches.
- Ensure the role has permission for the target toolbar menu.
- Verify the switch by logging in as a user with the role.
- Use with multiple Toolbar Menu entries to segment audiences.
- Provide a simplified navigation for editors vs. developers.
- Standardize toolbar navigation across a team by role.
- Change a role's menu and have users pick it up on next login.
- Audit which menu each role receives from one screen.
- Clear caches after changing the mapping if needed.
- Troubleshoot a missing menu by checking `access toolbar` grants.
- Store the mapping in exported configuration for deployment.
- Onboard new roles by adding a mapping row.