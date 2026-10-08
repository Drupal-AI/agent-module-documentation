<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Permissions Turbo provides high-performance permission management with lazy loading, instant search and delta-based saving, replacing the slow core permissions page.

---

Permissions Turbo provides a high-performance replacement for Drupal's core permissions administration
page — using lazy loading, instant search, and delta-based saving (only saving changed permissions) to make
the permissions UI fast even on sites with many modules/permissions (where the core page can be very slow to
load and save). It requires PHP 8.1, is at `/admin/people/permissions-turbo`, and provides its own
permissions.

Use it to make permission management usable on large sites. It is an administration UI tool; the routes are
correctly gated by the `administer permissions` permission (the same as core's page — a highly privileged
permission, since it controls who can grant/revoke any permission). The one thing to confirm when adopting is
correctness: because it uses **delta-based saving** (saving only changes), verify that permission edits are
applied exactly as intended (grants/revokes) — test that saving through Turbo produces the same result as the
core page. It has no access-control role beyond gating its own admin UI. Restrict `administer permissions`
tightly as always.

---

- Speed up the permissions admin page.
- Use lazy loading and instant search.
- Save only changed permissions (delta).
- Require PHP 8.1.
- Gate by administer permissions.
- Make permission management usable on large sites.
- Verify delta-saving correctness.
- Test edits match the core page.
- Restrict administer permissions tightly.
- Replace the slow core page.
- Provide its own permissions.
- Manage permissions fast.
- Search permissions instantly.
- Handle many permissions.
- Confirm grants/revokes apply exactly.
- Improve permissions UX.
- Use at /admin/people/permissions-turbo.
- Have no access role beyond gating.
- Manage roles/permissions.
- Optimize the permissions UI.
