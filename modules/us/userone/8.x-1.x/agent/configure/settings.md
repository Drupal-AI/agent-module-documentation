<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure User One

Route `userone.settings_form` → `/admin/config/people/userone`. **Access:** `_custom_access` grants only `uid == 1`; every other account (including "Administer users") is forbidden. There is no other route in the module.

## What protection is always on (code, not config)
- `userone_user_access`: forbids view/edit of the uid-1 user entity for any account except uid 1.
- `userone_views_query_alter`: adds `users_field_data.uid <> 1` to user-based views (hides uid 1 from people list, Who's Online/New). Ships `views.view.userone_who_s_online` for a correct online count.
- `userone_form_alter`: strips `userone` from `system_modules` / `system_modules_uninstall` for non-uid-1 accounts.

## Settings (`userone.settings`, editable by uid 1 only)
| Key | Meaning |
|---|---|
| `user_failed_login_ip_limit` | Failed attempts per IP before action (default 50). |
| `user_failed_login_ip_window` | Window in seconds the failures are counted over. |
| `block_ip_on_failed_login_ip` | If set, permanently ban offending IPs via `ban.ip_manager` on login. |
| `notify_user_one_on_failed_login_ip` | Email uid 1 when an IP is banned. |

## Notes
- Banning reads the core `flood` table (`user.failed_login_ip`) with a parameterised query and uses the `ban` module (a dependency). Banned IPs are managed at the core Ban admin page.
- The failed-login limit/window here override Drupal's built-in IP flood values and apply to **all** users, not just uid 1.
