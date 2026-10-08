<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User One (userone) — agent index

**Protects super-admin (uid 1): blocks view/edit and hides uid 1 from lists even for user administrators, and auto-bans brute-force login IPs via core Ban.**

- **Version:** 8.x-1.x (release 8.x-1.0-alpha2)  •  core `^8.8 || ^9 || ^10 || ^11`  •  package User  •  dep: ban
- **Route:** `userone.settings_form` (`/admin/config/people/userone`) — `_custom_access` = allowed **only if uid == 1**, else forbidden.
- **Hooks:** `userone_user_access` (forbid non-uid-1 on the uid-1 entity), `hook_views_query_alter` (`uid <> 1` on `users_field_data`), `hook_form_alter` (hide module from install/uninstall for non-uid-1), login validate → ban IPs from `flood` via `ban.ip_manager`.
- **Config:** `userone.settings` (`user_failed_login_ip_limit`, `user_failed_login_ip_window`, `block_ip_on_failed_login_ip`, `notify_user_one_on_failed_login_ip`).
- **Security:** settings route restricted to uid 1 only; no route grants/blocks/unblocks user 1 or changes access for others; protections can't be flipped into a bypass. Flood query is parameterised. Reviewed carefully — no security findings. See [configure/settings.md](configure/settings.md).