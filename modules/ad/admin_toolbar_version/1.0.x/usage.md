<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Admin toolbar version adds version information to the Admin Toolbar tools menu so admins can see the running version at a glance.

---

Install the module (requires Admin Toolbar's admin_toolbar_tools submodule). Configure at /admin/config/user-interface/admin-toolbar-version (permission: administer site configuration). A VersionInfoManager service resolves the version, including reading a git HEAD file when present.

---

- Show version info in the admin toolbar.
- Depend on admin_toolbar_tools.
- Read the core/profile version.
- Optionally read a git HEAD file for the deployed ref.
- Provide a settings form for display options.
- Gate config behind 'administer site configuration'.
- Resolve version through VersionInfoManager service.
- Display the version to authenticated admins.
- Serve as an admin convenience/fingerprint tool.
- Note: version disclosure is admin-only via the toolbar.
- Add a menu entry under the tools menu.
- Use the install profile in version resolution.
- Require the Admin Toolbar contrib module.
- Have a single admin settings route.
- Help operators confirm deployed versions.
- Keep information within the admin toolbar.
- Work across Drupal 8.8+ through 10.
- Provide no front-end output.
