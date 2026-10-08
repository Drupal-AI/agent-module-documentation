<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Lowercase Username (lowercase_username) — agent index

**Rejects usernames containing characters outside a configurable lowercase set** by adding a validate handler to the user form.

- **Version:** 8.x-1.x (8.x-1.5)
- **Core:** ^10.1 || ^11 || ^12
- **Depends on:** user
- **Configure:** `lowercase_username.settings` → `/admin/config/user-interface/lowercase_username` (perm `administer lowercase username`).
- **Logic:** `src/Hook/LowercaseUsernameHooks.php` — `formUserFormAlter()` adds `validateForm()`; pattern built from `username.numbers|dots|underscores|hyphens`.
- **Permissions:** `administer lowercase username`.
- **Security:** validates/rejects only — it does **not** transform or rename existing usernames, so it introduces no username-collision or account-takeover risk; core's case-insensitive uniqueness stays in effect. Settings route permission-gated; no anonymous/mutating endpoints.

See [configure/settings.md](configure/settings.md).