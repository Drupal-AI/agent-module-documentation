<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTPS and WWW Redirect — permissions

The module defines exactly two permissions, both marked `restrict access: true` in
`httpswww.permissions.yml`:

| Permission | Machine name | Gates |
|---|---|---|
| Administer HTTPS and WWW Redirects | `administer httpswww` | Access to the settings form at `/admin/config/system/httpswww` (the route's `_permission` requirement). Controls who can change `enabled`/`prefix`/`scheme`/`exclude_subdomains`. |
| Bypass HTTPS and WWW Redirects | `bypass httpswww redirect` | Exempts the current user from the redirect entirely. Checked first thing inside `HttpsWwwRedirectSubscriber::redirect()` — if the current user has this permission, the subscriber returns immediately and no 301 is issued, no matter what `httpswww.settings` says. |

`bypass httpswww redirect` matters operationally: the settings form itself warns that if you
lack this permission and you're on a host/scheme different from the one you're about to select,
saving the form can immediately log you out or redirect you away (because your own next request
gets redirected). Granting it to administrator roles before experimenting with scheme/prefix
changes avoids getting locked out mid-configuration. It is a pure request-time bypass — it does
not affect who can *change* the config, only who is *subject* to the redirect it produces.

Neither permission is granted to any role by default (both are `restrict access: true`, meaning
Drupal's permissions UI flags them as security-sensitive and they must be assigned deliberately).
