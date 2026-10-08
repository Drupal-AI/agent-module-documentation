<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Secure Admin Path changes the admin path (/admin, /user) to a custom prefix.

---

Secure Admin Path **renames the `/admin` and `/user` path prefixes to a custom string** — so the admin area
and user/login pages live at e.g. `/manage/...` instead of the well-known defaults, making them less obvious to
automated scanners/brute-forcers. It provides its own permissions, in the Administration package.

Use it to reduce automated attacks on the admin/login area. Understand precisely what it is: **security through
obscurity**. Renaming the paths **hides** the admin/login location from bots that hammer `/user/login` or `/admin`,
which cuts noise and some opportunistic attacks — but it is **not an access control**: a user who knows the custom
prefix reaches the same pages, and the real protection is still Drupal's **permissions and authentication** (strong
passwords, rate limiting/flood control, 2FA). So treat it as a defense-in-depth/noise-reduction layer only, never
as the boundary protecting your admin area. Configure the custom admin prefix.

---

- Rename /admin and /user path prefixes.
- Move the admin/login area to a custom prefix.
- Reduce automated scanning/brute-force.
- Provide its own permissions.
- Serve administration hardening.
- Hide the admin/login location from bots.
- BE security through obscurity (not an access control).
- Still let anyone who knows the prefix reach the pages.
- Rely on permissions/authentication for real protection (strong passwords, flood control, 2FA).
- Be a defense-in-depth/noise-reduction layer only.
- Configure the custom admin prefix.
- Handle the path rename.
- Rename paths.
- Configure the prefix.
- Move admin.
- Handle the routing.
- Obscure admin.
- Reduce noise.
- Not be the boundary.
- Provide admin-path obscuring.
