<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# OneTime LoginLink (onetimeloginlink) — agent index

**Admin form to mint a Drupal one-time login (password-reset) URL for a user by username/email, using core's `user_pass_reset_url()`.**

- **On-disk dir:** `onetimeloginlink` — **real machine name:** `onetime_loginlink` (info.yml prefix); project `onetimeloginlink`.
- **Version:** 8.x-1.x
- **Core:** ^8.8 || ^9 || ^10
- **Depends:** none
- **Configure:** `/admin/config/system/onetime-loginlink/settings` (route `onetime_loginlink.onetime_loginlink_form`), permission `administer onetime_loginlink` (`restrict access: TRUE`).

**Surface:** one form (`OneTimeLoginLinkForm`); no custom token logic.

**Security (reviewed — sound):** the link comes from **core `user_pass_reset_url()`** (secure token from password hash + last-login + site private key; time-limited, single-use). No weak custom crypto. Minting a link for another account is powerful but correctly gated by a `restrict access` admin permission; deliver the generated URL over a secure channel.
