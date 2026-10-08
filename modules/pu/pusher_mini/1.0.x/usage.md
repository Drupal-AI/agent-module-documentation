<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Pusher mini is a lightweight integration that hands the Pusher JavaScript client its app key and configuration and provides a server endpoint that authenticates the logged-in user with Pusher.
---
On every page, `HookPageBottom` (for users with `pusher_mini use`) prints a `window.PusherConfiguration` script containing the app key, cluster, TLS/transport options and — unless `disable_auth` is set — the URL of the user-auth endpoint. The app key and secret are read from a **Key entity** via the Key module (`PusherFactory::createPusher`, pusher_mini/src/PusherFactory.php:33), so credentials are not stored in module config; only the non-secret app key is exposed to the browser. Outbound Pusher connections default to `useTLS => TRUE`; TLS/scheme/host/port are only overridden when an explicit self-hosted `server.host` is configured by an admin.

The `/pusher/user-auth` route requires both `_user_is_logged_in: TRUE` and the `pusher_mini authenticate` permission, and `PusherAuth` validates the `socket_id` (string, ≤32 chars) before calling `authenticateUser` with the current user's id/info. A route subscriber conditionally enables the auth route based on configuration. Admin settings live at `/admin/config/services/pusher-mini` (`administer pusher_mini`).

Typical setup: create a Key holding `app_key`/`app_secret`, select it plus app id/cluster on the settings form, and grant `pusher_mini use` / `pusher_mini authenticate` as needed.
---
- Connect a Pusher JS client using injected config.
- Expose only the public app key to the browser.
- Store app key/secret in a Key entity (env, file, etc.).
- Authenticate the logged-in user for Pusher user channels.
- Gate the auth endpoint behind a permission.
- Restrict which roles load the Pusher client (`pusher_mini use`).
- Point the client at a self-hosted Pusher-compatible server.
- Force TLS on outbound Pusher calls.
- Toggle client stats reporting.
- Configure cluster and app id.
- Disable the auth endpoint when only public channels are used.
- Administer settings at `/admin/config/services/pusher-mini`.
- Vary the client script cache by user permissions.
- Rotate the Pusher secret by swapping the Key entity.
- Keep the app secret out of Drupal config.
- Serve the auth endpoint only to authenticated users.
