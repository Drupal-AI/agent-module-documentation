<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Shortcut per Role assigns a default core Shortcut set to each user role, so a user automatically sees the shortcut set configured for their role (highest-weight role wins) instead of always the site "default" set.

---

The module is a thin layer over core's `shortcut` module. It adds one settings form at `admin/config/user-interface/shortcut/roles` (route `shortcutperrole.admin_config`, permission "administer shortcut per role") that lists every role with a select of all existing shortcut sets. The chosen mapping is stored in simple config `shortcutperrole.settings` under `role.<role_id>: <shortcut_set_id>`. The behavior is delivered through `hook_shortcut_default_set($account)`: it loads all roles, intersects them with the account's roles preserving role order, takes the last (highest-weight) matching role, and returns the shortcut set configured for it (falling back to `default` when nothing is set). A `hook_user_role_delete` implementation cleans up the config entry when a role is deleted. There is no field, entity, or plugin of its own — the only persistent state is the `shortcutperrole.settings` config object, and it requires the core Shortcut module (and users with the "access shortcuts"/toolbar permissions) to have any visible effect.

---

- Give content editors a curated admin shortcut set while administrators get a fuller one.
- Assign a "Support" role its own shortcut set pointing at the tasks that team handles.
- Default new authenticated users to a minimal shortcut set instead of the site default.
- Show role-specific quick links in the toolbar without each user manually switching sets.
- Map the "administrator" role to a comprehensive shortcut set of common config pages.
- Let a multi-team site present different toolbar shortcuts per department role.
- Ensure users with multiple roles get the shortcut set of their highest-weight role.
- Standardise onboarding so every editor sees the same starting shortcuts.
- Replace per-user shortcut customization with role-driven defaults.
- Point a "shop manager" role at commerce-related admin shortcuts.
- Configure the mapping entirely through exported config (`shortcutperrole.settings`) for deployment.
- Quickly re-point a role to a different shortcut set after reorganising admin tasks.
- Reduce editor confusion by hiding admin shortcuts irrelevant to their role.
- Provide a translator role with shortcuts to translation and content pages.
- Keep the core "default" set for roles you have not explicitly mapped.
- Drive toolbar shortcuts from role membership in an SSO/externally-provisioned site.
- Automatically clean up the role→set mapping when a role is deleted.
- Curate a "reviewer" role's shortcuts around moderation and unpublished content.
- Give a "developer" role shortcuts to logs, cron, and performance pages.
- Manage all role shortcut defaults from a single admin form rather than per user.
