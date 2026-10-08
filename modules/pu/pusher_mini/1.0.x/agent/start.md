<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pusher mini (pusher_mini) — agent index
**Injects `window.PusherConfiguration` for the Pusher JS client and provides a logged-in-user auth endpoint.**

- **Version:** 1.0.x (dev checkout; info.yml 1.0.0-beta2)
- **Core:** >=10.1 · PHP 8.1 · **Depends on:** key
- **Routes:** `pusher_mini.auth` → `/pusher/user-auth` (`_user_is_logged_in` + `pusher_mini authenticate`); `pusher_mini.configuration_form` → `/admin/config/services/pusher-mini` (`administer pusher_mini`)
- **Permissions:** `administer pusher_mini`, `pusher_mini use`, `pusher_mini authenticate`
- **Services:** `PusherFactory` (Key-backed), `HookPageBottom`, route subscriber

**Security:** Secrets held in a Key entity (not config); browser receives only the app key. Auth route is login+permission gated and validates `socket_id` length. Outbound `useTLS => TRUE` by default (overridable only via admin-set self-hosted server config). No findings. See [configure/settings.md](configure/settings.md).
