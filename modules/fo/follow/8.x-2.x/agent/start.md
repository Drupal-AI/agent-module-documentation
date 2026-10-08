<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Follow (follow) — agent index

**Sitewide and per-user social-profile 'follow us' links, as blocks.**

- **Version:** 8.x-2.x  | **Core:** ^8.8 || ^9 || ^10  | **Package:** Integrations
- **Configure:** `follow.settings` (perm `manage follow settings`); per-user links at `/user/{user}/follow` (`FollowUserForm::access`).
- **Permissions:** manage follow settings, edit own follow links, edit any user follow links, view follow links.
- **Service:** `follow.manager` (uses `user.data`). Blocks: sitewide + per-user; Views field plugin; overridable templates/icons.

**Security:** per-user link editing gated by own/any permissions; settings gated by a dedicated permission. Nothing notable.
